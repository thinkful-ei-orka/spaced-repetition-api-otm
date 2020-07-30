const express = require('express')
const LanguageService = require('./language-service')
const { requireAuth } = require('../middleware/jwt-auth')

const languageRouter = express.Router()
const jsonBodyParser = express.json()

languageRouter
  .use(requireAuth)
  .use(async (req, res, next) => {
    try {
      const language = await LanguageService.getUsersLanguage(
        req.app.get('db'),
        req.user.id,
      )

      if (!language)
        return res.status(404).json({
          error: `You don't have any languages`,
        })

      req.language = language

      next()
    } catch (error) {
      next(error)
    }
  })

languageRouter
  .get('/', async (req, res, next) => {
    try {
      const words = await LanguageService.getLanguageWords(
        req.app.get('db'),
        req.language.id,
      )

      res.json({
        language: req.language,
        words,
      })
      next()
    } catch (error) {
      next(error)
    }
  })

languageRouter
  .get('/head', async (req, res, next) => {
    try {
      const words = await LanguageService.getLanguageWords(
        req.app.get('db'),
        req.language.id,
      );

      const head = req.language.head;
      word = words.filter(word => word.id === head)[0];

      res.json({
        word,
      });
    } catch (error) {
      console.log(error)
    }
  })

languageRouter
  .post('/guess', jsonBodyParser, async (req, res, next) => {
    const { wordId, guess } = req.body

    for (const field of ['wordId', 'guess']) {
      if (!req.body[field]) {
        return res.status(400).json({
          error: `Missing '${field}' in request body`
        })
      }
    }

    const word = await LanguageService.getLanguageWord(
      req.app.get('db'),
      wordId
    )

    // if the guess is right
    let guessToLower = guess.toLowerCase();
    let memory_value;
    let correct_count = word[0].correct_count;
    let incorrect_count = word[0].incorrect_count;
    let total_score = req.language.total_score;
    let head = word[0].next;

    if (guessToLower === word[0].translation) {
      memory_value = word[0].memory_value * 2;
      correct_count++;
      total_score++;
    } else {
      memory_value = 1;
      incorrect_count++;
    }

    // update the total score and head in the language
    let languageUpdate = {
      head: head,
      total_score: total_score
    };
    // LanguageService.updateUsersLanguage(
    //   req.app.get('db'),
    //   req.user.id,
    //   languageUpdate
    // );

    const words = await LanguageService.getLanguageWords(
      req.app.get('db'),
      req.language.id,
    )

    let currentWordId = wordId;
    let nextWordId;
    for (let i = 0; i < memory_value; i++) {
      let currentWord = words.filter((word) => word.id === currentWordId)[0];
      nextWordId = currentWord.next;
      currentWordId = nextWordId;
    }
    // this ID becomes the current word's next
    let nextWord = words.filter((word) => word.id === nextWordId)[0];
    let nextNextWordId = nextWord.next;

    // update the word that you're guessing on
    let wordUpdate = {
      memory_value: memory_value,
      correct_count: correct_count,
      incorrect_count: incorrect_count,
      next: nextNextWordId
    };
    // LanguageService.updateLanguageWord(
    //   req.app.get('db'),
    //   wordId,
    //   wordUpdate
    // );

    // update the word that comes before this word again
    let nextWordUpdate = {
      next: wordId
    };
    // LanguageService.updateLanguageWord(
    //   req.app.get('db'),
    //   nextWordId,
    //   nextWordUpdate
    // );

    console.log('wordId', wordId);
    console.log('wordUpdate', wordUpdate);
    console.log('nextWordId', nextWordId);
    console.log('nextWordUpdate', nextWordUpdate);

    res.send('implement me!')
  })

module.exports = languageRouter
