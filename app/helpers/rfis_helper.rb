module RfisHelper
  def subject_shortner(subject)
    length = subject.length
    return subject if length < 80
    index = subject[0..80].rindex(' ')
    index ? "#{subject[0..index-1]}..." : "#{subject[0..80]}..."
  end
end
