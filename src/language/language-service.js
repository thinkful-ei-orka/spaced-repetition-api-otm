const LanguageService = {
  getUsersLanguage(db, user_id) {
    return db
      .from('language')
      .select(
        'language.id',
        'language.name',
        'language.user_id',
        'language.head',
        'language.total_score'
      )
      .where('language.user_id', user_id)
      .first();
  },

  getLanguageWords(db, language_id) {
    return db
      .from('word')
      .select(
        'id',
        'language_id',
        'original',
        'translation',
        'next',
        'memory_value',
        'correct_count',
        'incorrect_count'
      )
      .where({ language_id });
  },

  getLanguageWord(db, word_id) {
    return db
      .from('word')
      .select(
        'id',
        'language_id',
        'original',
        'translation',
        'next',
        'memory_value',
        'correct_count',
        'incorrect_count'
      )
      .where({ id: word_id });
  },

  updateUsersLanguage(db, user_id, update) {
    // console.log(update);
    return db('language')
      .update(update)
      .where('user_id', user_id);
  },

  updateLanguageWord(db, word_id, update) {
    return db('word')
      .update(update)
      .where('id', word_id);
  }
};

module.exports = LanguageService;
