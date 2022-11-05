using MultivariatePolynomials 
using Polynomials 
using TypedPolynomials
using LinearAlgebra

# need to define those constants due to conflicts for Polynomials.Polynomial and Polynomials.degree as these functions are also defined for Multivariate polynomials
const mvp = MultivariatePolynomials
const p = Polynomials
const tp = TypedPolynomials


# We will define functions we need for our experiments that are not part of the packages MultivariatePolynomials or Polynomials for an intro to the most important functions of these packages take a look at the julia notebook Introduction_to_Polynomials.ipynb


function eye(n)
    """
    we need this function as I in julia is not a matrix but rather an operator
    """
    return I + zeros(n,n)
end

function mpRound(mvp_p,tol) 
    """ 
    Input: 
        mvp_p: polynomial object of MultivariatePolynomials
        tol: positive flaot (e.g tol = 1e-8)
    Ouput:
        rounded_mvp_p: multivariate polynomial only containing terms with coefficients that have an absolut value > t
    """
    rounded_mvp_p = 0
    cs = mvp.coefficients(mvp_p)
    for (k,monom) in enumerate(mvp.monomials(mvp_p))
        if norm(cs[k]) > tol
            rounded_mvp_p += cs[k]*monom
        end
    end
    return rounded_mvp_p
end

# We want to use functions that are only defined in Polynomials, but we cannot give it an object from multivariate polynomials as input even if the polynomial in question has only one variable. So we define a function converting a polynomial object in MultivariatePolynomials to an object in Polynomials. The coefficient function of multivar polys only returns the nonzero coefficients but if we want to construct an object in Polynomials from an object in MultivariatePolynomials we need a vector of coefficients with the 0 coefficients at the right place.

function NonsparseCoefficientsofmp(mvp_p)
    """
    This function returns a vector of coefficients from lowest to highest monomila of a mvp object including the 0 ones note here 
    we intrinsically assume that p is already univariate.
    
    Input: polynomial object of MultivariatePolynomials with only one variable
    Ouput: polynomial object of Polynomials 
    """
    len = maxdegree(mvp_p)
    nonsparscoeffs = zeros(len + 1)
    for (i,mon) in enumerate(mvp.monomials(mvp_p))
        k = mvp.degree(mon)
        nonsparscoeffs[k+1] = mvp.coefficients(mvp_p)[i]
    end
    return nonsparscoeffs
end

function mpToUni(mvp_p)
    """
    This function converts an object in MultivariatePolynomials to an object in Polynomials. Note here 
    we intrinsically assume that p is already univariate.
    
    Input: polynomial object of MultivariatePolynomials with only one variable
    Ouput: polynomial object of Polynomials 
    """
    cs = NonsparseCoefficientsofmp(mvp_p)
    uni_p = p.Polynomial(cs)
    return uni_p
end

# there is no roots function in MultivariatePolynomials, but if we have an object in MultivariatePolynomials wiht only one variable we can still calculate the roots:

function mpRoots(mvp_p)
    """
    This function computes the roots an object in MultivariatePolynomials. Note here 
    we intrinsically assume that p is already univariate.
    
    Input: polynomial object of MultivariatePolynomials with only one variable
    Ouput: vector containg the roots of mvp_p
    """
    uni_p = mpToUni(mvp_p) 
    return p.roots(uni_p) 
end

function poly_operator_poly(p,q,a)
    """
    Parses the polynomial p in variables z[1], ..., z[n] and turns a z[i] into a partial derivative in direction z[i]. This
    operator op_p then acts on the polynomial q.
    
    Input: 
        p: polynomial object in MultivariatePolynomials
        q: polynomial object in MultivariatePolynomials
        z: vector containing all variables occuring in p ordered according to mvp.coeffs(p) !double check if we can get rid of 
            this input
    Output:
    """
    
    terms_p = mvp.terms(p)
    output = 0
    for term in terms_p
        if term == 1
            output += q
        else
            q_curr = q
            c = mvp.coefficient(term)[1]
            derivs = mvp.exponents(term)
            for (i, elm) in enumerate(derivs)
                if elm > 0
                    q_curr = mvp.differentiate(q_curr,a[i],elm)
                end
            end
            output += c*q_curr
        end
    end
    return output
end
