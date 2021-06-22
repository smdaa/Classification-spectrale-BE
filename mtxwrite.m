function [err] = mtxwrite(A, filename)
    
fd = fopen(filename,'w');
if (fd == -1)
    error('Cannot open file for output');
end

n       = size(A, 1);
NZ      = nnz(A);

[I,J,V] = find(A);

precision = 16;

fprintf(fd,'%d %d %d\n', n, n, NZ);
for i=1:size(I)
    fprintf(fd,sprintf('%%d %%d %% .%dg\n',precision), I(i), J(i), V(i));
end


fclose(fd);
err = 0;
    
end

