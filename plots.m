
probs = [0.08 0.085 0.09 0.1];
for i = 1:4
   p = probs(i);
   h = subplot(2,2,i);
   telex_sim(p);
   title(['p =' num2str(p)]); 
end