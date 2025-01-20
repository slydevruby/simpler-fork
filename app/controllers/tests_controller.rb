# frozen_string_literal: true

# Controller
class TestsController < Simpler::Controller
  def plain
    # @time = Time.now
    # @tests = Test.all
    render plain: 'plain response'
  end

  def list
    render 'tests/list'
  end

  def create; end

  def show
    # @foo = params[:id]
    render 'tests/show'
  end
end
