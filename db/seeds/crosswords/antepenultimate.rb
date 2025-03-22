crosswords_data = Test::Utils.seed_data(:crosswords).sort_by { _1[:number] }

crosswords.create :antepenultimate, **crosswords_data[crosswords_data.size - 3]
