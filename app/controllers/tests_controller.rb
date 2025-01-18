# frozen_string_literal: true

# Controller
class TestsController < Simpler::Controller
  def index
    # render 'tests/list'
    # @time = Time.now
    # @tests = Test.all
    render plain: 'plain response'
  end

  def create; end

  def show
    # @foo = params[:id]
    render 'tests/show'
  end
end
