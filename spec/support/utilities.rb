# def random_letters
#   letter = (rand(122-97) + 97).chr
#   letter + letter + letter  
# end

def random_letters(n)
  letters = ('a'..'z').to_a.shuffle[0..n].join
end