module ApiTommy
  class Markdown
    1.upto(6).each do |level|
      self.class.send(:define_method, "h#{level}") { |text| title(text, level) }
    end

    def self.title(text, level)
      "\n#{'#' * level} #{text}\n"
    end

    def self.p(text)
      "\n#{text.gsub(/[\n]+/, " ")}\n"
    end

    def self.code(text, language = nil)
      result = "\n```"
      result << language unless language.nil?
      result << "\n#{text}\n```\n"
    end

    def self.ul(text)
      "* #{text}\n"
    end

    def self.th(*headers)
      "\n".tap do |result|
        headers.each { |header| result << "| #{header} " }
        result << "\n"
        headers.size.times.each { result << "| --- " }
        result << "\n"
      end
    end

    def self.tr(*values)
      ''.tap do |result|
        values.each { |value| result << "| #{value} " }
        result << "\n"
      end
    end
  end
end