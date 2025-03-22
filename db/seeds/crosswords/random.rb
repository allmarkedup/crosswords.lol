crosswords_data = Test::Utils.seed_data(:crosswords)

crosswords.create :random, **crosswords_data.slice(10, 100).sample
