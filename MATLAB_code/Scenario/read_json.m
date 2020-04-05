function db_cv = read_json(file_name)
%Read a .json file
%
%Author: Kevin Müller, 05.04.2020

    node_struct = 'nodes' ;
    user_name_field = 'id' ;
    postal_code_field = 'group' ;
    
    link_struct = 'links' ;
    user_1_field = 'source' ;
    user_2_field = 'target' ;
    
    json_data = jsondecode(fileread(file_name)) ;
    
    db_cv = memory_allocate_new_table(1064) ;
    num_node = length(json_data.(node_struct)) ;
    
    for m1 = 1 : num_node
        db_cv = user_create_account(db_cv, json_data.(node_struct)(m1).(user_name_field),...
            json_data.(node_struct)(m1).(postal_code_field)) ;
    end
    
    num_link = length(json_data.(link_struct)) ;
    
    for m1 = 1 : num_link
        name_1 = json_data.(link_struct)(m1).(user_1_field) ;
        name_2 = json_data.(link_struct)(m1).(user_2_field) ;
        db_cv = user_add_link(db_cv, name_1, name_2) ;
        db_cv = user_add_link(db_cv, name_2, name_1) ;
    end
    
end