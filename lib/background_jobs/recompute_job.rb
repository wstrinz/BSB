class RecomputeJob
  def self.run
    if !@job || maybe_cleanup!
      @job = Job.new
      @current_status = "started"
      @job.start
      @job
    else
      raise 'job already running'
    end
  end

  def self.maybe_cleanup!
    if @job && @job.thread && !@job.thread.alive?
      @job = nil
      true
    else
      false
    end
  end

  def self.poll
    if @job
      s = @job.fetch_status
      if s
        @current_status = s
        if s == :done
          @job = nil
        end
        s
      else
        @current_status
      end
    else
      "no job running"
    end
  end

  class Job
    def initialize
      @queue = Queue.new
      @started = false
    end

    def start
      raise "Thread started!" if @started
      @started = true
      @thread = Thread.new do
        count = Story.where(read: false).count
        interval = (count.to_f * 0.01).round
        pretty_percent = ->(num,denom){ ( ( num.to_f / denom.to_f ) * 100 ).round(2) }
        Story.where(read: false).each_with_index do |s, i|
          s.recompute_score
          if i % interval == 0
            @queue << "#{pretty_percent.call(i, count)} % of #{count} stories processed"
          end
          s.save!
        end
        @queue << :done
      end
    end

    def fetch_status
      if @queue.empty?
        nil
      else
        @queue.pop(true)
      end
    end

    def done?
      @thread && !@thread.alive?
    end

    def thread
      @thread
    end
  end
end
