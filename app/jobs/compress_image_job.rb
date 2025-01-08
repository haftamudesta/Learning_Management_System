class CompressImageJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    course=Course.find(course_id)
    return unless course.image.attached?
    retries ||=3
    begin
      io=course.image.download
      
      image=MiniMagick::Image.read(io)
      image.format("jpeg")
      image.resize "100X100"
      image.quality 5

      processed_i0 =StringIo.new(image.to_blob)
      course.image.attach(io: processed_i0,filename: course.image.filename.to_s, content_type: course.image.content_type)
      
      Rails.logger.info("MoniMagick Processed the image")
    rescue MiniMagick::Error=>e
      rails.loger.error("MinMagick Processing Failed")
      if(retries -=1)>0
        sleep 1
        retry
        else
          Rails.logger.error("All retries Failed")
          raise
    end
    end
  end
end
