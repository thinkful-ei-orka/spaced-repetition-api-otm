const bcrypt = require('bcryptjs')

const REGEX_UPPER_LOWER_NUMBER_SPECIAL = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&])[\S]+/

const UserService = {
  hasUserWithUserName(db, username) {
    return db('user')
      .where({ username })
      .first()
      .then(user => !!user)
  },
  insertUser(db, newUser) {
    return db
      .insert(newUser)
      .into('user')
      .returning('*')
      .then(([user]) => user)
  },
  validatePassword(password) {
    if (password.length < 8) {
      return 'Password be longer than 8 characters'
    }
    if (password.length > 72) {
      return 'Password be less than 72 characters'
    }
    if (password.startsWith(' ') || password.endsWith(' ')) {
      return 'Password must not start or end with empty spaces'
    }
    if (!REGEX_UPPER_LOWER_NUMBER_SPECIAL.test(password)) {
      return 'Password must contain one upper case, lower case, number and special character'
    }
    return null
  },
  hashPassword(password) {
    return bcrypt.hash(password, 12)
  },
  serializeUser(user) {
    return {
      id: user.id,
      name: user.name,
      username: user.username,
    }
  },
  populateUserWords(db, user_id) {
    // console.log('adding words');
    return db.transaction(async trx => {
      // console.log('adding language');
      const [languageId] = await trx
        .into('language')
        .insert([
          { name: 'French', user_id },
        ], ['id'])

      // when inserting words,
      // we need to know the current sequence number
      // so that we can set the `next` field of the linked language
      const seq = await db
        .from('word_id_seq')
        .select('last_value')
        .first()

      const languageWords = [
        ['Bonjour', 'hello', 2],
        ['Au revoir', 'goodbye', 3],
        ['Oui', 'yes', 4],
        ['Non', 'no', 5],
        ['Merci', 'thank you', 6],
        ['Merci beaucoup', 'thank you very much', 7],
        ['Fille', 'girl', 8],
        ['Garcon', 'boy', 9],
        ['Femme', 'woman', 10],
        ['Homme', 'man', 11],
        ['Amour', 'love', 12],
        ['Francais', 'french', 13],
        ['S&#39il vous plait', 'please', 14],
        ['Bonsoir', 'good evening', 15],
        ['Bonne Nuit', 'good night', 16],
        ['Excusez-moi', 'excuse me', 17],
        ['De Rien', 'you&#39re welcome (casual)', 18],
        ['Je vous en prie', 'you&#39re welcome (formal)', 19],
        ['Temps', 'time', 20],
        ['Jour', 'day', 21],
        ['Monde', 'world', 22],
        ['Monsieur', 'mister', 23],
        ['Raison', 'reason', 24],
        ['Madame', 'miss', 25],
        ['Beau', 'handsome', 26],
        ['Belle', 'beautiful', 27],
        ['Chat', 'cat', 28],
        ['Chien', 'dog', 29],
        ['Fort', 'strong', null],
      ]

      // console.log('adding words');
const [languageHeadId] = await trx
  .into('word')
  .insert(
    languageWords.map(([original, translation, nextInc]) => ({
      language_id: languageId.id,
      original,
      translation,
      next: nextInc
        ? Number(seq.last_value) + nextInc
        : null
    })),
    ['id']
  )

  // console.log('updating head');
await trx('language')
  .where('id', languageId.id)
  .update({
    head: languageHeadId.id,
  })
    })
  },
}

module.exports = UserService
