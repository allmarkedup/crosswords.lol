crosswords_data = SeedData.load(:crosswords).sort_by { _1[:number] }

crosswords.create :earliest, **crosswords_data.first
