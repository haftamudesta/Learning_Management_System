class CompressVideoJob < ApplicationJob
  queue_as :default

  def perform(course_id)
  #   course=Course.find(course_id)
  #   return unless course.video.attached?
  #   retries ||=3
  #   begin
  #     io=course.video.download

  #    input_file=Tempfile.new(['original_video',File.extname(course.video.filename.to_s),binmode: true])
  #    input_file.write(io)
  #    input_file.rewind()

  #    movie=FFMPEG::Movie.new(input_file.path)
  #    output_file=Tempfile.new("processed_video",'.mp4')

  #    options={resolution: "640x640",video_bitrate: 500, audio_bitrate: 64}
  #    movie.transcode(output_file.path,options)

      
  #     course.video.attach(io: File.open(output_file.path),filename: course.video.filename.to_s, content_type: course.video.content_type)
      
  #     Rails.logger.info("Video Processed successfully")
  #   rescue MiniMagick::Error=>e
  #     rails.loger.error("FFMEG Processing Failed: #{e.message}")
  #     if(retries -=1)>0
  #       sleep 1
  #       retry
  #       else
  #         Rails.logger.error("All retries Failed")
  #         raise
  #   end
  #   end
  # end
end
