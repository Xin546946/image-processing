function [deblurred2] = gamma_calculation(H, blurred_noisy, noise_mean, noise_var,gamma)
    [hei,wid,~] = size(H);
    iteration = 0;
    
    p = [0 -1 0;-1 4 -1;0 -1 0];%laplace operator
    P = psf2otf(p,[hei,wid]);
    numerator = conj(H);%conj
    If = fft2(blurred_noisy);
    denominator = H.^2 + gamma*(P.^2);
    deblurred2 = ifft2( numerator.*If./ denominator );

    a = norm(blurred_noisy - H * deblurred2, 2) - hei*wid*(noise_mean*noise_mean + noise_var*noise_var);
    
    while(abs(a)>1e3)

        If = fft2(blurred_noisy);

        denominator = H.^2 + gamma*(P.^2);
        deblurred2 = ifft2( numerator.*If./ denominator );
        a = norm(blurred_noisy - H * deblurred2, 2) - hei*wid*(noise_mean*noise_mean + noise_var*noise_var)
        
        gamma = gamma -0.0001
        iteration = iteration +1
        if iteration == 999
            break
        end
    end
    
    
    denominator = H.^2 + gamma*(P.^2);
    deblurred2 = ifft2( numerator.*If./ denominator );
    
end