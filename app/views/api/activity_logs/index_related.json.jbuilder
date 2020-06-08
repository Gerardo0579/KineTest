Time.zone = 'America/Monterrey'

json.array! @activity_log do |act|
    json.id act.id
    json.baby_id act.baby_id

    json.start_time Time.strptime(act.start_time.to_s, "%Y-%m-%d %k:%M:%S")
    json.stop_time Time.strptime(act.stop_time.to_s, "%Y-%m-%d %k:%M:%S") unless (act.stop_time.nil?)
    
    #Si se busca el id 0, regresará todos, en cuyo caso incluye el nombre del bebé
    json.baby_name act.baby_name if act.respond_to? :baby_name
    
    json.assistant_name act.assistant_name
    json.activity_name act.activity_name
end