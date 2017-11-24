class KakaoController < ApplicationController
  def keyboard
    keyboard = {
    :type => "buttons",
    :buttons => ["로또", "메뉴", "고양이"]
    }
    
    # keyboard = {
    #   :type => "text"
    # }
    render json: keyboard
    
  end

  def message
    msg = "안녕"
    
    basic_keyboard  = {
      :type => "buttons",
      :buttons => ["로또", "메뉴", "고양이"]
    }
    
    user_msg = params[:content]
    if user_msg == "로또"
      msg = (1..46).to_a.sample(6).to_s
    elsif user_msg == "메뉴"
      msg = ["배고파?", "다이어트", "샐러드", "김밥"].sample
    elsif user_msg == "고양이"
    cat_api = RestClient.get 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1@type=jpg'
    doc = Nokogiri::XML(cat_api)
    cat_url = doc.xpath("//url").text
    msg = cat_url
    else
      msg = "?????"
    end
    
    message = {
      text: msg
    }
    message_photo= {
      photo: {
        url: cat_url,
        width:640,
        height:480
      }
    }

    basic_keyboard  = {
      :type => "buttons",
      :buttons => ["로또", "메뉴", "고양이"]
    }

    
    # basic_message = {
    #   "message" => {
    #     "text" => msg
    #   }
    # }
    
    if user_msg == "고양이"
      result = {
        message: message_photo,
        keyboard: basic_keyboard
      }
    else
      result = {
        message: message,
        keyboard: basic_keyboard
      }
    end
    
    render json: result
  end
end

