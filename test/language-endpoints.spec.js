const app = require('../src/app')
const helpers = require('./test-helpers')

describe('Language Endpoints', function () {
  let db

  const testUsers = helpers.makeUsersArray()
  const [testUser] = testUsers
  const [testLanguages, testWords] = helpers.makeLanguagesAndWords(testUser)

  before('make knex instance', () => {
    db = helpers.makeKnexInstance()
    app.set('db', db)
  })

  after('disconnect from db', () => db.destroy())

  before('cleanup', () => helpers.cleanTables(db))

  afterEach('cleanup', () => helpers.cleanTables(db))

  /**
   * @description Endpoints for a language owned by a user
   **/
  describe(`Endpoints protected by user`, () => {
    const languageSpecificEndpoint = [
      {
        title: `GET /api/language/head`,
        path: `/api/language/head`,
        method: supertest(app).get
      },
      {
        title: `POST /api/language/guess`,
        path: `/api/language/guess`,
        method: supertest(app).post
      },
    ]

    languageSpecificEndpoint.forEach(endpoint => {
      describe(endpoint.title, () => {
        beforeEach('insert users, languages and words', () => {
          return helpers.seedUsersLanguagesWords(
            db,
            testUsers,
            testLanguages,
            testWords
          )
        })

        it(`responds with 404 if user doesn't have any languages`, () => {
          return endpoint.method(endpoint.path)
            .set('Authorization', helpers.makeAuthHeader(testUsers[1]))
            .send({})
            .expect(404, {
              error: `You don't have any languages`,
            })
        })
      })
    })
  })

  /**
   * @description Get languages for a user
   **/
  describe(`GET /api/language`, () => {
    const [usersLanguage] = testLanguages.filter(
      lang => lang.user_id === testUser.id
    )
    const usersWords = testWords.filter(
      word => word.language_id === usersLanguage.id
    )

    beforeEach('insert users, languages and words', () => {
      return helpers.seedUsersLanguagesWords(
        db,
        testUsers,
        testLanguages,
        testWords
      )
    })

    it(`responds with 200 and user's language and words`, () => {
      return supertest(app)
        .get(`/api/language`)
        .set('Authorization', helpers.makeAuthHeader(testUser))
        .expect(200)
        .expect(res => {
          expect(res.body).to.have.keys('language', 'words')

          expect(res.body.language).to.have.property('id', usersLanguage.id)
          expect(res.body.language).to.have.property('name', usersLanguage.name)
          expect(res.body.language).to.have.property('user_id', usersLanguage.user_id)
          expect(res.body.language).to.have.property('total_score', 0)
          expect(res.body.language).to.have.property('head')
            .which.is.not.null

          usersWords.forEach((usersWord, idx) => {
            const word = res.body.words[idx]
            expect(word).to.have.property('id', usersWord.id)
            expect(word).to.have.property('original', usersWord.original)
            expect(word).to.have.property('translation', usersWord.translation)
            expect(word).to.have.property('memory_value', 1)
            expect(word).to.have.property('correct_count', 0)
            expect(word).to.have.property('incorrect_count', 0)
          })
        })
    })
  })

  /**
   * @description Get head from language
   **/
  describe(`GET /api/language/head`, () => {
    const usersLanguage = testLanguages.find(l => l.user_id === testUser.id)
    const headWord = testWords.find(w => w.language_id === usersLanguage.id)

    beforeEach('insert users, languages and words', () => {
      return helpers.seedUsersLanguagesWords(
        db,
        testUsers,
        testLanguages,
        testWords
      )
    })

    it(`responds with 200 and user's languages`, () => {
      return supertest(app)
        .get(`/api/language/head`)
        .set('Authorization', helpers.makeAuthHeader(testUser))
        .expect(200)
        .expect({
          word: {
            correct_count: 0,
            id: headWord.id,
            incorrect_count: 0,
            language_id: headWord.language_id,
            memory_value: 1,
            next: 2,
            original: headWord.original,
            translation: headWord.translation
          }
          // nextWord: headWord.original,
          // totalScore: 0,
          // wordCorrectCount: 0,
          // wordIncorrectCount: 0,
        })
    })
  })

  /**
   * @description Submit a new guess for the language
   **/
  describe(`POST /api/language/guess`, () => {
    const [testLanguage] = testLanguages
    const testLanguagesWords = testWords.filter(
      w => w.language_id === testLanguage.id
    )

    beforeEach('insert users, languages and words', () => {
      return helpers.seedUsersLanguagesWords(
        db,
        testUsers,
        testLanguages,
        testWords
      )
    })

    it(`responds with 400 required error when 'guess' is missing`, () => {
      const postBody = {
        randomField: 'test random field',
      }

      return supertest(app)
        .post(`/api/language/guess`)
        .set('Authorization', helpers.makeAuthHeader(testUser))
        .send(postBody)
        .expect(400, {
          error: `Missing 'guess' in request body`,
        })
    })

    context(`Given incorrect guess`, () => {
      const incorrectPostBody = {
        guess: 'incorrect',
      }

      it(`responds with incorrect and moves head`, () => {

        // it(`responds with incorrect and moves head`, () => {
        it(`updates the incorrect count and updates the next word`, () => {
          return supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(incorrectPostBody)
            .expect(200)
            .expect({
              wordId: 1,
              wordUpdate: {
                memory_value: 1,
                correct_count: 0,
                incorrect_count: 1,
                next: 3
              },
              nextWordId: testLanguagesWords[1].id,
              nextWordUpdate: {
                next: 1
              }
              // totalScore: 0,
              // wordCorrectCount: 0,
              // wordIncorrectCount: 0,
              // answer: testLanguagesWords[0].translation,
              // isCorrect: false
            })
        })

        it(`moves the word 1 space and updates incorrect count`, async () => {
          await supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(incorrectPostBody)

          await supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(incorrectPostBody)
            .expect({
              wordId: 2,
              wordUpdate: {
                memory_value: 1,
                correct_count: 0,
                incorrect_count: 1,
                next: 3
              },
              nextWordId: testLanguagesWords[0].id,
              nextWordUpdate: {
                next: testLanguagesWords[1].id
              }
              // nextWord: testLanguagesWords[0].original,
              // totalScore: 0,
              // wordCorrectCount: 0,
              // wordIncorrectCount: 1,
              // answer: testLanguagesWords[1].translation,
              // isCorrect: false
            })
        })
      })

      context(`Given correct guess`, () => {
        const testLanguagesWords = testWords.filter(
          word => word.language_id === testLanguage.id
        )

        it(`responds with correct and moves head`, () => {
          const correctPostBody = {
            guess: testLanguagesWords[0].translation,
          }
          return supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(correctPostBody)
            .expect(200)
            .expect({
              wordId: 1,
              wordUpdate: {
                memory_value: 2,
                correct_count: 1,
                incorrect_count: 0,
                next: testLanguagesWords[3].id,
              },
              nextWordId: testLanguagesWords[2].id,
              nextWordUpdate: {
                next: testLanguagesWords[0].id
              }
              // nextWord: testLanguagesWords[1].original,
              // totalScore: 1,
              // wordCorrectCount: 0,
              // wordIncorrectCount: 0,
              // answer: testLanguagesWords[0].translation,
              // isCorrect: true
            })
        })

        it(`moves the word 2 spaces, increases score and correct count`, async () => {
          let correctPostBody = {
            guess: testLanguagesWords[0].translation,
          }
          await supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(correctPostBody)

          correctPostBody = {
            guess: testLanguagesWords[1].translation,
          }
          await supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(correctPostBody)
            .expect({
              wordId: testLanguagesWords[1].id,
              wordUpdate: {
                memory_value: 2,
                correct_count: 1,
                incorrect_count: 0,
                next: testLanguagesWords[3].id,
              },
              nextWordId: testLanguagesWords[0].id,
              nextWordUpdate: {
                next: testLanguagesWords[1].id
              }
              // nextWord: testLanguagesWords[2].original,
              // totalScore: 2,
              // wordCorrectCount: 0,
              // wordIncorrectCount: 0,
              // answer: testLanguagesWords[1].translation,
              // isCorrect: true
            })

          correctPostBody = {
            guess: testLanguagesWords[2].translation,
          }
          await supertest(app)
            .post(`/api/language/guess`)
            .set('Authorization', helpers.makeAuthHeader(testUser))
            .send(correctPostBody)
            .expect({
              wordId: testLanguagesWords[2].id,
              wordUpdate: {
                memory_value: 2,
                correct_count: 1,
                incorrect_count: 0,
                next: testLanguagesWords[3].id,
              },
              nextWordId: testLanguagesWords[1].id,
              nextWordUpdate: {
                next: testLanguagesWords[2].id
              }
              // nextWord: testLanguagesWords[0].original,
              // totalScore: 3,
              // wordCorrectCount: 1,
              // wordIncorrectCount: 0,
              // answer: testLanguagesWords[2].translation,
              // isCorrect: true
            })
        })
      })
    })
  })
})
