class Queue
  attr_accessor :current_queue

  def initialize(current_queue)
    @current_queue = current_queue
  end

  def clear_queue
    @current_queue = []
  end

  def queue_count
    @current_queue.length
  end

  def queue_save


  end

  def queue_print
    

  end

end