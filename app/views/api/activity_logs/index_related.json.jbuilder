json.array! @activity_logs do |act|
    json.id act.id
    json.baby_id act.baby_id
    json.start_time act.start_time
    json.stop_time act.stop_time unless (act.stop_time > Time.new)
    
    #Si se busca el id 0, regresará todos, en cuyo caso incluye el nombre del bebé
    json.baby_name act.baby_name unless act.baby_name.nil?
    
    json.assistant_name act.assistant_name
    json.activity_name act.activity_name
end