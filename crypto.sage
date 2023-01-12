
###############################
#        exercice 11          #
###############################


def my_gcd(a,b):
	while (b != 0):
		tmp = b
		b = a%b
		a = tmp
	return a


def my_xgcd(a, b):
    if a == 0 :
        return b,0,1
             
    gcd,x1,y1 = my_xgcd(b%a, a)
    x = y1 - (b//a) * x1
    y = x1
     
    return gcd,x,y



def my_pow(x,e, n=None):
    assert n != 0, "mod cannot be 0"
    y = 1
    while (e != 0):
        if (e%2 == 1):
            y = (x*y)%n if (n != None) else x*y
        x = (x**2)%n if (n!= None) else x**2
        e = e//2
    return y

#assert my_pow(1,2,3) == pow(1,2,3)
#assert my_pow(6,5,4) == pow(6,5,4)
#assert my_pow(11,2) == pow(11,2)
#assert my_pow(9,8) == pow(9,8)
#assert my_pow(11,8,1) == pow(11,8,1)
#assert my_pow(123,321,100) == pow(123,321,100)
#assert my_pow(8,9,4) == pow(8,9,4)
#assert my_pow(100,20,60) == pow(100,20,60)



def my_is_prime(n):
    # k = 10
    base = [2,3,5,7]
    if n == 1 or n == 4:
        return False
    elif n == 2 or n == 3 or n==5 or n==7:
        return True
    else:
        # for i in range(k):
        for a in base:
            if pow(a, n - 1, n) != 1:
                return False             
    return True


def my_next_prime(k):
    while True:
        k += 1
        if (my_is_prime(k)): return k
        

###############################
#          exercice 12        #
###############################

import time

def test_factor():
    l = 3
    while(l <= 111):
        rq = randrange(2, 2**l)
        q = next_prime(rq)
        rp = randrange(2, 2**l)
        p = next_prime(rp)
        N = p * q
        start = time.time()
        factor(N)
        stop = time.time()
        print (f" {l}  {(stop - start) * 10^6}")
        l = l + 1



###############################
#          exercice 13        #
###############################


# return e,N,d ----------- (e,N) cle publique, d cle prive

def rsa_gen(l):
    rq = randrange(2**(l-1),2**l)
    q = next_prime(rq)
    rp = randrange(2**(l-1),2**l)
    p = next_prime(rp)
    N = p*q
    phi_N = (p-1)*(q-1)
    while True:
        e = randrange(0,phi_N)
        if (my_gcd(phi_N,e) == 1): break
    gcd,d,k = my_xgcd(e, phi_N)
    # print(f"e={e} phi_N={phi_N} d={d} k={k} {e*d+phi_N*k}")
    if d < 0 : d = d+phi_N
    if k < 0 : k = k+phi_N
    # print(f"e={e} phi_N={phi_N} d={d} k={k} {e*d+phi_N*k}")
    # print(f"e={e} N={N} d={d}")
    return e,N,d

def rsa_enc(e,N,M):
    if (M>=N):
        raise Exception(" M muste be less than N")
    return my_pow(M,e,N)

def rsa_dec(d,N,C):
    return my_pow(C,d,N)


def text_to_dec(s):
    li = []
    for c in s:
        li.append(f"{ord(c):03}")
    return int("".join(li))

def dec_to_text(n):
    s = str(n)
    l = len(s)%3
    s = "0"*(3-l) + s if l != 0 else s
    li = []
    for i in range(0,len(s),3):
        li.append(chr(int(s[i:i+3])))
    return "".join(li)


"""
l = 512
e,N,d = rsa_gen(l)
sage: e
16990033746519365592230522948768141069878399509351173555183529990833558349858490663471453095700032607830955538195692774405633686865893395389337578473276291806526089113456656447126063105062420231538126871247915960662416176320464295469145420496538766882543459234626480667342673522263624005448261687491701622399
sage: N
82938779233255954614180202005930572750135350545637362221663176534813847047094904155709528992782737860386981155374598517738600734389102567772827932397952801438453407846408024599238865595245566555091101169717027032687099673522772224728380285271163046372495428225641270175081471263975713383859364341546449111509
sage: d
66266797693988104884626616187479374519771351246693711390279187191464296934232949974509750009356957251784886750087837830257452359514537020821817373665350222475640060968947718786271037139956917806874740352638894013447663069178107710577173577521671944626510396323567883380677678883816641764358149391876007580779

M = text_to_dec('Hello World') = 72101108108111032087111114108100

sage: C = rsa_enc(e,N,M)
50206635388377138196093631698354812949656707159224794197118489145136372462594150733339408067579017122350793307087346403506737914864997480878022968831453455831253989472850979727104091118648624410989990694868986734685109077615325693134544325468644423366016287583213081109149172312924837894439742803655459495640

sage: dec_to_text(rsa_dec(d,N,C))
'Hello World'
"""