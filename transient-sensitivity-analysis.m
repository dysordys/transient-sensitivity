(* ::Package:: *)

(* Jacobian matrix of the model
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - t: the symbolic time variable to be used in the returned expression
Output:
  - the Jacobian matrix at time t *)
transJacobian[model_,vars_,t_]:=Outer[D,model[vars,t][[All,2]],Through[vars[t]]];

(* Derivative of the model with respect to a parameter
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - par: the parameter by which the model should be differentiated
  - t: the symbolic time variable to be used in the returned expression
Output:
  - list of derivatives of the right hand sides of the model with respect to par,
    at time t *)
transInhomogeneous[model_,vars_,par_,t_]:=D[model[vars,t][[All,2]],par];

(* Obtain solution to discrete-time model with given parameters and
   initial conditions
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - ic: list of initial conditions
  - pars: a list of parameter replacement rules, defining the parameter values
  - tmax: time at which the model iteration is terminated
Output:
  - a table of replacement rules for each variable at each time step:
    its [[t,k]]th entry is the replacement rule for variable k at time t *)
transSolveModelDiscrete[model_,vars_,ic_,pars_,tmax_]:=Module[{t},
    Return[
        Partition[Thread[Flatten[Table[
	    Through[vars[t]],{t,0,tmax}]]->Flatten[RecurrenceTable[
	        Join[model[vars,t]/.pars, Thread[Through[vars[0]]==ic]],
	vars,{t,0,tmax}]]],Length[vars]]
    ]
];

(* Obtain transient sensitivities around a given solution and parameter settings,
   for a discrete-time model
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - pars: a list of parameter replacement rules, defining the parameter values
  - par: the parameter to be perturbed
  - sol: the solution around which the sensitivities are calculated
  - tmax: time at which the model iteration is terminated
Output:
  - the matrix of sensitivities whose [[t,i]]th entry is the sensitivity of
    variable i at time t to perturbing par *)
transGetSensitivityDiscrete[model_,vars_,pars_,par_,sol_,tmax_]:=Module[{s,a,z,t},
    s=Table[0,{tmax+1},{Length[vars]}];
    a=Table[transJacobian[model,vars,t]/.pars/.Flatten[sol],{t,0,tmax-1}];
    z=Table[transInhomogeneous[model,vars,par,t]/.pars/.Flatten[sol],{t,0,tmax}];
    Do[s[[k+1]]=z[[k]]+a[[k]].s[[k]],{k,1,tmax}];
    Return[s]
];

(* Obtain solution to continuous-time model with given parameters and
   initial conditions
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - ic: list of initial conditions
  - pars: a list of parameter replacement rules, defining the parameter values
  - t: the symbolic time variable to be used in the returned expression
  - tmax: time at which the model iteration is terminated
  - opts: optional parameters passed to NDSolve (e.g., AccuracyGoal or PrecisionGoal)
Output:
  - the solution as a list of replacement rules;
    its ith entry is the solution for variable i *)
transSolveModelContinuous[model_,vars_,ic_,pars_,t_,tmax_,opts:OptionsPattern[]]:=Flatten[
    NDSolve[
        Join[model[vars,t]/.pars,Thread[Through[vars[0]]==ic]],Through[vars[t]]
    ,{t,0,tmax},FilterRules[{opts}, Options[NDSolve]]]
];

(* Obtain transient sensitivities around a given solution and parameter settings,
   for a continuous-time model
Input:
  - model: the model definition, in the form of a list of dynamical equations
  - vars: the list of dynamical variables
  - pars: a list of parameter replacement rules, defining the parameter values
  - par: the parameter to be perturbed
  - sol: the solution around which the sensitivities are calculated;
         its time argument is used for that of the sensitivities as well
  - tmax: time at which the model iteration is terminated
  - opts: optional parameters passed to NDSolve (e.g., AccuracyGoal or PrecisionGoal)
Output:
  - list of sensitivities, whose ith entry is the sensitivity
    (as a function of time) of the ith dynamical variable to perturbing par *)
transGetSensitivityContinuous[model_,vars_,pars_,par_,sol_,tmax_,opts:OptionsPattern[]]:=Module[
    {t,sig,s,a,z,ic},
    t=sol[[1,1]][[1]];
    sig=Table[s[i][t],{i,1,Length[vars]}];
    a=transJacobian[model,vars,t]/.pars/.Flatten[sol];
    z=transInhomogeneous[model,vars,par,t]/.pars/.Flatten[sol];
    ic=Thread[(sig/.t->0)==0];
    Return[
        Flatten[NDSolveValue[Join[Thread[D[sig,t]==z+a.sig],ic],sig,{t,0,tmax},FilterRules[{opts}, Options[NDSolve]]]]
    ]
];

