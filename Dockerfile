FROM docker.bluelight.limited:5000/bluelightltd/microkube-install-image

# ENV RUBY_VER=2.5.3
ENV RUBY_VER=2.6.0


WORKDIR /home/app/microkube/

# # # 
USER app
RUN     . /etc/rvmrc && \
        export PATH="$PATH:/usr/local/rvm/bin/" && \
        export PATH="/usr/local/rvm/rubies/ruby-$RUBY_VER/bin:$PATH" && \
        rvm use --default $RUBY_VER && \
        echo "Replacing in multiple files" && \
        sed -i 's/EVENT_API_RABBITMQ_HOST=rabbitmq/EVENT_API_RABBITMQ_HOST=\[\"rabbitmq:5672\"\]/g' templates/config/*.env.erb && \
        sed -i 's/EVENT_API_RABBITMQ_PORT=5672/EVENT_API_RABBITMQ_PORT=/g' templates/config/*.env.erb && \
        # sed -i 's/rabbitmq/\[\"rabbitmq.microkube\"\]/g' templates/config/*.env.erb && \
        # sed -i 's/rabbitmq/rabbitmq.microkube-peatio/g' templates/config/peatio.env.erb && \
        # sed -i 's/rabbitmq/rabbitmq.microkube-barong/g' templates/config/barong.env.erb && \
        # sed -i 's/rabbitmq/rabbitmq.microkube-ranger/g' templates/config/ranger.env.erb && \
        # sed -i 's/rabbitmq/rabbitmq.microkube-postmaster/g' templates/config/postmaster.env.erb && \
        rake render:config && \
        sed -i 's/3.6/3.3/g' compose/* && \
        sed -i 's/33.3/3306/g' compose/* && \
        echo "Finished setup" 
        


#CMD ["/bin/bash", "-c", "top"]