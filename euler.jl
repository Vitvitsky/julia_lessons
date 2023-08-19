#=
Нахождение решения a^5+b^5+c^5+d^5=e^5, где a, b, c, d, e < 150
=#
counter = false
count_i = 0
function sum_of_fifth_powers_1()
    #=
    итераций 7964127, время выполнения с count_i ~ 0.4сек
    без count_i ~ 0.17сек
    =#
    counter = false
    count_i = 0
    for a in 150:-1:1
        a5 = a^5
        for b in a-1:-1:1
            b5 = b^5 + a5
            for c in b-1:-1:1
                c5 = c^5 + b5
                for d in c-1:-1:1
                    d5 = d^5 + c5
                    e = Int(floor(d5^0.2))
                    count_i += 1
                    if d5 == e^5
                        println("a=$a, b=$b, c=$c, d=$d, e=$e, a+b+c+d+e=$(a+b+c+d+e)")
                        counter = true
                        break
                    end
                end
                if counter == true
                    break
                end
            end
            if counter == true
                break
            end
        end
        if counter == true
            break
        end
    end
    println("Итераций = $count_i")
end

function sum_of_fifth_powers_2()
    #= 
    идея подчерпнута https://stepik.org/lesson/298795/step/13?discussion=7239173&thread=solutions&unit=280622
    итераций 2863605, 
    время выполнения с count_i ~ 0.16 сек
    без count_i ~ 0.06сек

    =#
    count_i = 0
    for e in 150:-1:4
        e5 = e^5
        for a in 1:e-3
            a5 = a^5
            if a5 > e5
                break
            end
            for b in a+1:e-3
                b5 = b^5
                if a5 + b5 > e5
                    break
                end
                for c in b+1:e-3
                    c5 = c^5
                    if a5 + b5 + c5 > e5
                        break
                    end
                    d = Int(floor((e5 - a5 - b5 - c5)^0.2))
                    count_i += 1
                    if e5 - a5 - b5 - c5 == d^5
                        println("a=$a, b=$b, c=$c, d=$d, e=$e, a+b+c+d+e=$(a+b+c+d+e)")
                        global counter = true
                        break
                    end
                end
                if counter == true
                    break
                end
            end
            if counter == true
                break
            end
        end
        if counter == true
            break
        end
    end
    println("Итераций = $count_i")
end


function sum_of_fifth_powers_3()
    #= общая идея (a^5 + b^5) = e^5 - (c^5 + d^5)
    https://stepik.org/lesson/298795/step/13?discussion=7179809&thread=solutions&unit=280622
    Итераций = 1505276
    время выполнения ~ 0.10 сек

    =#
    count_i = 0
    my_list = [i^5 for i in 1:150]
    amounts = Dict()

    # вычисление и заполнение словаря (a^5 + b^5), что будет аналогично и паре (c^5 + d^5)
    for i in my_list
        for j in my_list
            if i != j && (i + j) <= 150^5
                amounts[i + j] = [i, j]
            end
        end
    end

    answer_flag = false

    for i in my_list
        for key in keys(amounts)
            count_i += 1
            # сравниваем e^5 - (a^5 + b^5), есть ли разница в amounts
            if (i - key) > 0 && (i - key) in keys(amounts)
                a = Int(floor(i^(1/5)))
                b = Int(floor(amounts[i - key][1]^(1/5)))
                c = Int(floor(amounts[i - key][2]^(1/5)))
                d = Int(floor(amounts[key][1]^(1/5)))
                e = Int(floor(amounts[key][2]^(1/5)))
                sum = a + b + c + d + e

                println("a=$a, b=$b, c=$c, d=$d, e=$e, a+b+c+d+e=$sum")
                answer_flag = true
                break
            end
        end

        if answer_flag
            break
        end
    end
    println("Итераций = $count_i")
end

@time sum_of_fifth_powers_1()
@time sum_of_fifth_powers_2()
@time sum_of_fifth_powers_3()
