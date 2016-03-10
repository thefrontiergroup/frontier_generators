module Frontier::ErrorReporter

  def report_error(text)
    unless is_test_environment?
      puts(text)
    end
  end

private

  def is_test_environment?
    !ENV["_"].nil? && ENV["_"].include?("rspec")
  end

end
