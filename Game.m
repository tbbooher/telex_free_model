classdef Game < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
        num_conversations = 10;     % how many folks will a participant talk to in a week?
        p_convert = 0.1;            % how likely is someone to convert an uninitiated person?
        phi = 0;                  % tree array
        i = 0;                      % number of participants
        num_weeks = 7;              % number of weeks
        folks = {};
        boss_wealth = 0;
    end
    
    methods
        
        function obj = Game
           was = Participant(0);
           obj.folks = {was};
        end
        
        function recruit(o, iWeek) 
           for iParticipant = 1:length(o.folks)
            p1 = o.folks{iParticipant};
            for iC = 1:o.num_conversations
               if rand < o.p_convert
                  o.i = o.i + 1;
                  % [last_side] = find_side(p1.side);
                  disp(['adding participant: ' num2str(o.i)]);
                  p = Participant(o.i);
                  o.folks{1+ end} = p;
                  p1.add_recruit(p);
                  o.phi(p.index+1) = p1.index+1;
                  treeplot(o.phi);
                  disp(['Person ' num2str(p1.index) ' has recruited person ' num2str(p.index)]);
%                   pause;
               end % convert
            end % num_conversations
          end % participants
        end % recruit
        
%         function collect(o, iWeek)
%           for iF = 1:numel(o.folks)
%             o.boss_wealth = o.boss_wealth -    
%         end % collect
    end
    
end

