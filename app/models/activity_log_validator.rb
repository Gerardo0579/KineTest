class ActivityLogValidator < ActiveModel::Validator

    def validate(record)
      if record.new_record?
        validate_create record
      else
        validate_update record
      end
    end

    def validate_create(record)
      
      begin
        time = Time.strptime(record.start_time.to_s, "%Y-%m-%d %k:%M:%S")
        record.start_time = time
      rescue => exception
        record.errors[:start_time] << 'Start time MUST be a valid date time'
      end

    end

    def validate_update(record)

      begin
        time = Time.strptime(record.stop_time.to_s, "%Y-%m-%d %k:%M:%S")
        record.stop_time = time
        if record.start_time.to_datetime > record.stop_time.to_datetime
          record.errors[:stop_time] << 'Stop time MUST occurs after start time'
        else
          record.duration = ((record.stop_time - record.start_time) / 1.minute).round
        end          
      rescue => exception
        record.errors[:stop_time] << 'Stop time MUST be a valid date time'  
      end

    end


  end