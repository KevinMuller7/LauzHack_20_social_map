function db_cv = test_script_1()
%Create a scenario
%It must start with "memory_allocate_new_table"
%
%Each action done by the user is equivalent to a call to a 'user_"name of
%the action"' function. The format of this function is:
%   db_cv = user_"action"(db_cv, "user name", input parameter) ;
%db_cv is the database
%
%Author: Kevin Müller, 05.04.2020

    %22 names and location
    list_str = {'Boulou', 'Anna', 'Fred', 'George', 'Lisa', 'Mona',...
    	'Alfred', 'Benny', 'Minimini', 'Hector', 'Jean-jean', 'Belno',...
    	'Morgan', 'Zoe', 'BGeck', 'Duking', 'Archimede', 'DRidge', 'Mustafa',...
        'Gerard', 'LKelner', 'Lola'} ;
    
    list_post = [1005, 1005, 1150, 1150, 1350, 1150, 1005, 1150, 1150,...
    	1256, 1256, 1350, 1150, 1350, 1256, 1005, 1350, 1350, 1005, 1256,...
        1256, 1150] ;
    
    db_cv = memory_allocate_new_table(1064) ;
    
    %Add users
    for m1 = 1 : length(list_post)
        db_cv = user_create_account(db_cv, list_str{m1}, list_post(m1)) ;
    end
    
    %Make some one sided link
%     for m1 = [7, 4, 13, 12, 1]
%         db_cv = user_add_link(db_cv, 'Fred', list_str{m1}) ;
%     end
%     db_cv = user_add_link(db_cv, 'Belno', 'Jean-jean') ;
%     db_cv = user_add_link(db_cv, 'Jean-jean', 'Belno') ;
%     db_cv = user_delete_link(db_cv, 'Belno', 'Jean-jean') ;
%     db_cv = user_delete_link(db_cv, 'Jean-jean', 'Belno') ;

    for m1 = [7, 19, 13, 12, 1]
        db_cv = user_add_link(db_cv, 'LKelner', list_str{m1}) ;
    end
%     db_cv = user_change_state(db_cv, 'LKelner', 0) ;

    db_cv = user_add_link(db_cv, 'Morgan', 'LKelner') ;
%     db_cv = user_change_state(db_cv, 'Morgan', 2) ;
    db_cv = user_add_link(db_cv, 'Boulou', 'LKelner') ;
    
    %Loop
    db_cv = user_add_link(db_cv, 'Boulou', 'Morgan') ;
    db_cv = user_add_link(db_cv, 'Morgan', 'Boulou') ;

    %Line
    db_cv = user_add_link(db_cv, 'Minimini', 'Morgan') ;
    db_cv = user_add_link(db_cv, 'Morgan', 'Minimini') ;
    db_cv = user_add_link(db_cv, 'Minimini', 'Hector') ;
    db_cv = user_add_link(db_cv, 'Hector', 'Minimini') ;
    db_cv = user_add_link(db_cv, 'BGeck', 'Hector') ;
    db_cv = user_add_link(db_cv, 'Hector', 'BGeck') ;
%     db_cv = user_change_state(db_cv, 'LKelner', 2) ;
    db_cv = user_change_state(db_cv, 'Hector', 2) ;
    
end

