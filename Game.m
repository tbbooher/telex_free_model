classdef Game < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
%         num_conversations = 5;    % how many folks will a participant talk to in a week?
        p_convert = 0;              % how likely is someone to convert an uninitiated person?
        phi = 0;                    % tree array
        i = 0;                      % number of participants
        num_weeks = 7;              % number of weeks
        folks = {};
        boss_wealth = 0;
        participants_wealth = [];
        n = 1;                     % total participants
    end
    
    methods
        
        function obj = Game(p)
           obj.p_convert = p;
           was = Participant(0,1);
           obj.folks = {was};
        end
        
        function recruit(o, iWeek) 
           for iParticipant = 1:length(o.folks)
            p1 = o.folks{iParticipant};
%             disp([num2str(p1.index) ' has ' num2str(p1.NumConversations(iWeek)) ' in week ' num2str(iWeek)]);
            for iC = 1:p1.NumConversations(iWeek)
               if rand < o.p_convert && o.n < 500
                  o.n = o.n + 1;
                  o.i = o.i + 1;
                  % [last_side] = find_side(p1.side);
%                   disp(['adding participant: ' num2str(o.i)]);
                  p = Participant(o.i, iWeek);
                  o.folks{1+ end} = p;
                  p1.add_recruit(p);
                  o.phi(p.index+1) = p1.index+1;
                  treeplot(o.phi);
%                   disp(['Person ' num2str(p1.index) ' has recruited person ' num2str(p.index)]);
%                   pause;
               end % convert
            end % num_conversations
          end % participants
        end % recruit
        
        function collect(g, iWeek)
          % each person 
          for iF = 1:numel(g.folks)
            p = g.folks{iF};
            weeks = iWeek - p.start_week;
            g.ad_central(p, weeks);
            g.members(p);
%             g.binary_bonus;
          end % iF
        end % collect
        
        function members(g, p)
            payout = min(p.downstream_count*0.4, 3000);
            g.transfer(p, -payout);
%             disp([' **** %%%% **** downstream ' num2str(p.downstream_count)]);
        end
        
        function ad_central(g, p, weeks)
            % adcentral payments
            switch weeks
                case 0
                    g.transfer(p, 300);
                case 1
                    % nothing happens here -- you don't get paid
                otherwise
                    g.transfer(p, -20);                
            end            
        end % ad_central
        
        function transfer(g, p, amount)
           % amount + => to boss
           g.boss_wealth = g.boss_wealth + amount;
           p.wealth = p.wealth - amount; 
        end
        
        function report(g)
           figure;
           n = numel(g.folks);
           g.participants_wealth = zeros(1,n);
           for k = 1:n
             g.participants_wealth(k) = g.folks{k}.wealth;
           end % i
           bar(g.participants_wealth);
           winners = numel(g.participants_wealth(g.participants_wealth>0));
           losers = n - winners;
           title(['Boss: ' num2str(g.boss_wealth) ' winners: ' num2str(winners) ' losers: ' num2str(losers)]);
        end
    end
    
end

