function G = wienerfilter(H,K)
G=conj(H)./(H.*conj(H) + (1/K));
end