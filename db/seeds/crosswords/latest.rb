crosswords_data = Test::Utils.seed_data(:crosswords).sort_by { _1[:number] }

crosswords.create :latest, **crosswords_data.last
