crosswords_data = Test::Utils.seed_data(:crosswords).sort_by { _1[:number] }

crosswords.create :penultimate, **crosswords_data[crosswords_data.size - 2]
