# Tombot

Tombot is Line bot for tombo house, the share house I live in now. This is implemented by Ruby on Rails and deployed by Heroku with Scheduler and Fixie.

**Command examples**

    tmb_ping                              #=> return pong, mainly for runnig check
    tmb_set-cleaning-date_2017/1/1        #=> set cleaning date for the house
    tmb_get-cleaning-date                 #=> return current scheduled cleaning date
    tmb_set-daijin                        #=> set person in charge for throwing away garbage mannually
    tmb_hat                               #=> return random residents name
    tmb_help                              #=> return all commands
    

**Reminders**

* Cleaning date reminder
* Paying rent reminder
* Garbage reminder




