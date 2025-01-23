# frozen_string_literal: true

class TestsController < Simpler::Controller
  def plain
    render plain: 'plain response'
  end

  def list
    @tests = Test.all
    render 'tests/list'
  end

  def create; end

  def show
    @foo = params[:id]
    render 'tests/show'
  end

  def foobar
    @foo = params[:foo]
    @bar = params[:bar]
    render 'tests/foobar'
  end
end
