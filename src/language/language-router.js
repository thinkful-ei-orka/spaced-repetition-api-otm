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
    // implement me
    res.send('implement me!')
  })

languageRouter
  .post('/guess', jsonBodyParser, async (req, res, next) => {
    try {
      for (const [key, value] of Object.entries(req.body)) {
        if (value == null || key !== 'guess') {
          return res.status(400).json({error: `Missing 'guess' in request body`});
        }
      }
    } catch (e) {
      console.log(e);
    }

    const { guess } = req.body;

    const words = await LanguageService.getLanguageWords(
      req.app.get('db'),
      req.language.id,
    )

    // console.log(guess);

    // If the answer is correct, double the memory_value
    // If the answer is incorrect, reset memory_value to 1
    // Move the question back M places in the list
    // Use a singly linked list

    res.send('implement me!')
  })

module.exports = languageRouter
