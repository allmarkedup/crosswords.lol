crosswords_data = SeedData.load(:crosswords)

crosswords.create :random, **crosswords_data.sample
