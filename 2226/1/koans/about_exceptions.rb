require File.expand_path(File.dirname(__FILE__) + '/neo')
# docs
# :reek:IrresponsibleModule
# :reek:DuplicateMethodCall
# :reek:TooManyStatements
class AboutExceptions < Neo::Koan
  # docs
  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  def test_rescue_clause
    begin
      raise 'Oops'
    rescue StandardError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, ex.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, ex.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError), 'RuntimeError is a subclass of StandardError'
  end

  # rubocop:disable Lint/HandleExceptions
  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', ex.message
  end

  def test_ensure_clause
    begin
      raise 'Oops'
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end
  # rubocop:enable Lint/HandleExceptions
  # Sometimes, we must know about the unknown
  # def test_asserting_an_error_is_raised
  #   # A do-end is a block, a topic to explore more later
  #   assert_raise(StandardError) do
  #     raise MySpecialError.new('New instances can be raised directly.')
  #   end
  # end
end
