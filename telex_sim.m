function [boss_wealth, g] = telex_sim(prob, weeks)

close all;

g = Game(prob);
boss_wealth = zeros(1,weeks);

% last_side = -1;             % start building tree on the left

for iWeek = 1:weeks
  disp(['*********** Week: ' num2str(iWeek) ' ************* ']);
  if iWeek > 10 && g.boss_wealth/(g.n*20) < 5
    break;
  end
  g.recruit(iWeek);
  g.collect(iWeek);
  boss_wealth(iWeek) = g.boss_wealth;
%   g.sell;
end
g.report;

disp(['Total Recruits ' num2str(g.i)]);


end

% function [side, last_side] = find_side(last_side)
%         last_side = -1*last_side;
%         side = last_side;
% end

