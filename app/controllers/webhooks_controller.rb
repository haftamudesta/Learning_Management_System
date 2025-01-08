class WebhooksController < ApplicationController
        skip_forgery_protection
        def stripe
                stripe_secret_key=ENV['SECRET_KEY']
                Stripe.api_key= stripe_secret_key
                payload = request.body.read
                sig_header = request.headers['HTTP_STRIPE_SIGNATURE']
                endpoint_secret=ENV['STRIPE_WEBHOOK_SECRET_KEY']
                event=nil,
                begin 
                        event = Stripe::Webhook.construct_event(
                                payload, sig_header,endpoint_secret)
                        rescue JSON::ParserError => e
                                render json: { error: "Invalid payload" }, status: :bad_request
                                return
                              rescue Stripe::SignatureVerificationError => e
                                render json: { error: "Invalid signature" }, status: :bad_request
                                return
                end
                case event.type
                        when 'checkout.session.completed'
                                session=event.data.object
                                full_session=Stripe::Checkout:Session.retrieve({
                                        id:session.id,
                                        expand:['line_items']
                                })
                                        line_items=full_session.line_items
                                        course_id=session.metadata.course_id
                                        user=User.find_by!(email: session.customer_email)
                                        CourseUser.create!(course: course, user: user)
                        else
                                puts "unhandle event type:#{event.type}"
                        end
                        render json: { message: "Success" }
                
        end
end
