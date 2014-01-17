classdef Participant < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wealth = 0;
        recruits = {};
        recruited = []; % array of how many were recruited in each iteration
        upstream = [];
        index = 0;
        downstream_count = 0;
        start_week = 0;
        memberships = 1;
        zealot = false;
%         side = 0; % -1 = left; 1 = right; 0 = master
%         side_sums = [0 0];          % how many are on each side? (rows are levels col1 = left)
    end
    
    methods
        function p = Participant(index, iWeek, zealot)
            p.index = index;
            p.start_week = iWeek;
            p.zealot = zealot;
            if zealot
              p.memberships = 1;
            end
%             p.side = side;
        end
        
        function add_recruit(this_obj, new_obj)
           this_obj.recruits{end+1} = new_obj;
           new_obj.upstream = this_obj;
           this_obj.downstream_count = this_obj.downstream_count + 1;
%            index = (1/2)* side + 1/2+1;
%            this_obj.side_sums(index) = this_obj.side_sums(index) + 1;
        end
        
        function conversations = NumConversations(p, iWeek)
           % the zealous new convert
           weeks = iWeek - p.start_week;
           if p.zealot
               if weeks > 6
                   conversations = 1;
               else
                   conversations = 6 - weeks;
               end
           else
               conversations = double((rand > 0.8));
           end
        end
    end
    
end

