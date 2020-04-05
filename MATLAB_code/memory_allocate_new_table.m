function db_cv = memory_allocate_new_table(init_size)
%Allocate memory.
%Input:
%   - initial size of the database. (create up to "init_size" account
%   without increasing the size of the database)
%This file contains the structure to the database. There are 3 tables:
% - user: contains private information (typically, user name)
% - node: contains information for data collection (health state, postal
% code)
% - link: contains all the social links and their state (one-sided link,
% validated link)
%
%%Author: Kevin Müller, 05.04.2020
    
    init_hole = 128 ;

    data_struct = {'string', 'User name'} ;
    
    db_cv.user = create_dynamic_table(data_struct, init_size, init_hole) ;

    data_struct = cell(3,2) ;
    data_struct(1,:) = {'uint32', 'Postal code'} ;
    data_struct(2,:) = {'uint8', 'Health state'} ;
    %healthy(0), sick(1), sick (corona)(2), critical (corona)(3), recovered (4)
    data_struct(3,:) = {'uint64', 'Address to link'} ; %Address to link data
    
    db_cv.node = create_dynamic_table(data_struct, init_size, init_hole) ;
    
    data_struct = cell(11,2) ;
    for m1 = 1 : 2 : 9
        data_struct(m1,:) = {'uint64', [num2str((m1+1)/2), ': Address to node']} ;
        data_struct(m1+1,:) = {'uint8', [num2str((m1+1)/2), ': Link state']} ;
        %No link (0), one-sided(1), deletion pending (2), validated (3)
    end
    data_struct(11,:) = {'uint64', 'Address to link'} ;
    
    db_cv.link = create_dynamic_table(data_struct, init_size, init_hole) ;

end

function ddata = create_dynamic_table(data_struct, init_size, init_hole)

    ddata.d = table('Size', [init_size, size(data_struct,1)],...
        'VariableTypes', data_struct(:,1),...
        'VariableNames', data_struct(:,2)) ;
    ddata.h = zeros(init_hole, 1,'uint64') ;
    ddata.h(1) = 1 ;
    ddata.c = 1 ;

end
