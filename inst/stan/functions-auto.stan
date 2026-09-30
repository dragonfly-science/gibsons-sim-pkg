functions{
  vector trans_probs1(int instate, int nstates, real s_ad, real s_ado, real s_juv,
					  real p_mv_out, real p_mv_in, int succ, array[] real p_breed,
					  real p_rec, real p_bead, real p_succ) {
    /** TRANSITIONS and SURVIVAL **/

    // 1: adults breeding inside SA
    // 2: adults breeding outside SA
    // 3: adults non-breeding inside SA
    // 4: adults non-breeding outside SA
    // 5: ados inside SA
    // 6: ados outside SA
    // 7: juvs inside SA
    // 8: juvs outside SA
    // 9: deads
	vector[nstates] tmat1;

	if (instate == 1) { //* ADULTS PREVIOUSLY BREEDING WITHIN STUDY AREA *//
	  // re-breeding in SA (SA = study area)
	  tmat1[1] = succ == 2 ?
		0 :
		(succ == 1 ?
		 p_breed[1] * s_ad * (1-p_mv_out) :
		 (1-p_succ) * p_breed[1] * s_ad * (1-p_mv_out));
	  // re-breeding outside SA
	  tmat1[2] = succ == 2 ?
		0 :
		(succ == 1 ?
		 p_breed[1] * s_ad *    p_mv_out  :
		 (1-p_succ) * p_breed[1] * s_ad *    p_mv_out);
	  // non-breeding in SA
	  tmat1[3] = succ == 2 ?
		s_ad * (1-p_mv_out) :
		(succ == 1 ?
		 (1-p_breed[1]) * s_ad * (1-p_mv_out) :
		 (1-p_succ) * (1-p_breed[1]) * s_ad * (1-p_mv_out) +
		 p_succ * s_ad * (1-p_mv_out));
	  // non-breeding outside SA
	  tmat1[4] = succ == 2 ?
		s_ad * p_mv_out :
		(succ == 1 ?
		 (1-p_breed[1]) * s_ad * p_mv_out :
		 (1-p_succ) * (1-p_breed[1]) * s_ad * p_mv_out +
		 p_succ * s_ad * p_mv_out);
	  // ados inside SA
	  tmat1[5] = 0;
	  // ados outside SA
	  tmat1[6] = 0;
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead
	  tmat1[9] = 1-s_ad;

	} else if (instate == 2) { //* ADULTS PREVIOUSLY BREEDING OUTSIDE STUDY AREA *//
	  // re-breeding in SA (SA = study area)
	  tmat1[1] = succ == 2 ?
		0 :
		(succ == 1 ?
		 p_breed[1] * s_ad * p_mv_in :
		 (1-p_succ) * p_breed[1] * s_ad * p_mv_in);
	  // re-breeding outside SA
	  tmat1[2] = succ == 2 ?
		0 :
		(succ == 1 ?
		 p_breed[1] * s_ad * (1-p_mv_in) :
		 (1-p_succ) * p_breed[1] * s_ad * (1-p_mv_in));
	  // non-breeding in SA
	  tmat1[3] = succ == 2 ?
		s_ad * p_mv_in :
		(succ == 1 ?
		 (1-p_breed[1]) * s_ad * p_mv_in :
		 (1-p_succ) * (1-p_breed[1]) * s_ad * p_mv_in  +  p_succ * s_ad * p_mv_in);
	  // non-breeding outside SA
	  tmat1[4] = succ == 2 ?
		s_ad * (1-p_mv_in) :
		(succ == 1 ?
		 (1-p_breed[1]) * s_ad * (1-p_mv_in) :
		 (1-p_succ) * (1-p_breed[1]) * s_ad * (1-p_mv_in)  +  p_succ * s_ad * (1-p_mv_in));
	  // ados inside SA
	  tmat1[5] = 0;
	  // ados outside SA
	  tmat1[6] = 0;
	  // juvs
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead
	  tmat1[9] = 1-s_ad;

	} else if (instate == 3) { //* ADULTS PREVIOUSLY NOT BREEDING WITHIN STUDY AREA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] =    p_breed[2]  * s_ad * (1-p_mv_out);
	  // breeding outside SA
	  tmat1[2] =    p_breed[2]  * s_ad *    p_mv_out;
	  // non-breeding in SA
	  tmat1[3] = (1-p_breed[2]) * s_ad * (1-p_mv_out);
	  // non-breeding outside SA
	  tmat1[4] = (1-p_breed[2]) * s_ad *    p_mv_out;
	  // ados inside SA
	  tmat1[5] = 0;
	  // ados outside SA
	  tmat1[6] = 0;
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead
	  tmat1[9] = 1-s_ad;

	} else if (instate == 4) { //* ADULTS PREVIOUSLY NOT BREEDING OUTSIDE THE STUDY AREA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] =    p_breed[2]  * s_ad *    p_mv_in;
	  // breeding outside SA
	  tmat1[2] =    p_breed[2]  * s_ad * (1-p_mv_in);
	  // non-breeding in SA
	  tmat1[3] = (1-p_breed[2]) * s_ad *    p_mv_in;
	  // non-breeding outside SA
	  tmat1[4] = (1-p_breed[2]) * s_ad * (1-p_mv_in);
	  // ados inside SA
	  tmat1[5] = 0;
	  // ados outside SA
	  tmat1[6] = 0;
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead  
	  tmat1[9] = 1-s_ad;

	} else if (instate == 5) { //* ADOLESCENTS INSIDE THE STUDY AREA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] = s_ado * p_bead * (1-p_mv_out);
	  // breeding outside SA
	  tmat1[2] = s_ado * p_bead *    p_mv_out;
	  // non-breeding in SA
	  tmat1[3] = 0;
	  // non-breeding outside SA
	  tmat1[4] = 0;
	  // ados inside SA
	  tmat1[5] = s_ado * (1-p_bead) * (1-p_mv_out);
	  // ados outside SA
	  tmat1[6] = s_ado * (1-p_bead) *    p_mv_out;
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead  
	  tmat1[9] = 1-s_ado;

	} else if (instate == 6) { //* ADOLESCENTS OUTSIDE THE STUDY AREA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] = s_ado * p_bead *    p_mv_in;
	  // breeding outside SA
	  tmat1[2] = s_ado * p_bead * (1-p_mv_in);
	  // non-breeding in SA
	  tmat1[3] = 0;
	  // non-breeding outside SA
	  tmat1[4] = 0;
	  // ados inside SA
	  tmat1[5] = s_ado * (1-p_bead) *    p_mv_in;
	  // ados outside SA
	  tmat1[6] = s_ado * (1-p_bead) * (1-p_mv_in);
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = 0;
	  // dead  
	  tmat1[9] = 1-s_ado;
	  
	} else if (instate == 7) { //* JUVENILES INSIDE SA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] = 0;
	  // breeding outside SA
	  tmat1[2] = 0;
	  // non-breeding in SA
	  tmat1[3] = 0;
	  // non-breeding outside SA
	  tmat1[4] = 0;
	  // ados inside SA
	  tmat1[5] = s_juv * p_rec * (1-p_mv_out);
	  // ados outside SA
	  tmat1[6] = s_juv * p_rec *    p_mv_out;
	  // juvs inside SA
	  tmat1[7] = s_juv * (1-p_rec);
	  // juvs outside SA 
	  tmat1[8] = 0;
	  // dead  
	  tmat1[9] = 1-s_juv;
	  
	} else if (instate == 8) { //* JUVENILES OUTSIDE SA *//
	  // breeding in SA (SA = study area)
	  tmat1[1] = 0;
	  // breeding outside SA
	  tmat1[2] = 0;
	  // non-breeding in SA
	  tmat1[3] = 0;
	  // non-breeding outside SA
	  tmat1[4] = 0;
	  // ados inside SA
	  tmat1[5] = s_juv * p_rec * p_mv_in;
	  // ados outside SA
	  tmat1[6] = s_juv * p_rec * (1-p_mv_in);
	  // juvs inside SA
	  tmat1[7] = 0;
	  // juvs outside SA
	  tmat1[8] = s_juv * (1-p_rec);
	  // dead  
	  tmat1[9] = 1-s_juv;
	  
	} else if (instate == 9) { //* DEADS *//
	  // breeding in SA (SA = study area)
	  tmat1[1] = 0;
	  // breeding outside SA
	  tmat1[2] = 0;
	  // non-breeding in SA
	  tmat1[3] = 0;
	  // non-breeding outside SA
	  tmat1[4] = 0;
	  // ados inside SA
	  tmat1[5] = 0;
	  // ados outside SA
	  tmat1[6] = 0;
	  // juvs inside SA  
	  tmat1[7] = 0;
	  // juvs outside SA  
	  tmat1[8] = 0;
	  // dead  
	  tmat1[9] = 1;
	  
	}
	return tmat1;
  }



  
  row_vector obs_probs1(int latstate, int n_obs_states, array[] real p_obs, real p_detect_juv, real p_detect_dead,
					real p_female, real p_succ, int succ, int no_visit) {

	/** OBSERVED STATES **/

	// 1: adults breeding in SA
	// 2: adults non-breeding in SA
	// 3: adults outside SA
	// 4: ados inside SA
	// 5: ados outside SA
	// 6: juvs inside SA
	// 7: juvs outside SA
	// 8: dead
	// 9: not seen

    row_vector[n_obs_states] pmat1;
    real withvisit;

	if (no_visit == 1) {
	  withvisit = 0;
	} else withvisit = 1;

	if (latstate == 1) { //* ADULTS BREEDING WITHIN STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = withvisit * p_obs[1];
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[1];

	} else if (latstate == 2) { //* ADULTS BREEDING OUTSIDE STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = withvisit * p_obs[5];
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[3];

	} else if (latstate == 3) { //* ADULTS NON-BREEDING INSIDE STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = no_visit == 1 ?
		0 :
		(succ == 2 ?
		 p_obs[2] :
		 (succ == 1 ?
		  p_obs[3] :
		  p_succ * p_obs[2] + (1-p_succ) * p_obs[3]));
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[2];

	} else if (latstate == 4) { //* ADULTS NON-BREEDING OUTSIDE STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = withvisit * p_obs[5];
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[3];

	} else if (latstate == 5) { //* ADOS INSIDE STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = withvisit * p_obs[4];
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[2];

	} else if (latstate == 6) { //* ADOS OUTSIDE STUDY AREA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = withvisit * p_obs[5];
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[3];

	} else if (latstate == 7) { //* JUVENILES INSIDE SA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = withvisit * p_detect_juv;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[4];

	} else if (latstate == 8) { //* JUVENILES OUTSIDE SA *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = withvisit * p_detect_juv;
	  // dead  
	  pmat1[6] = 0;
	  // not seen
	  pmat1[7] = 1 - pmat1[5];

	} else if (latstate == 9) { //* DEADS *//
	  // ad breeding in SA (SA = study area)
	  pmat1[1] = 0;
	  // non-breeding in SA
	  pmat1[2] = 0;
	  // outside SA
	  pmat1[3] = 0;
	  // juvs inside SA
	  pmat1[4] = 0;
	  // juvs outside SA
	  pmat1[5] = 0;
	  // dead  
	  pmat1[6] = withvisit * p_detect_dead;
	  // not seen
	  pmat1[7] = 1 - pmat1[6];
	
	}
	return pmat1;
  }

  
  matrix trans_probs(int nstates, real s_ad, real s_ado, real s_juv,
					 real p_mv_out, real p_mv_in, int succ, array[] real p_breed,
					 real p_rec, real p_bead, real p_succ) {
    
    matrix[nstates, nstates] tmat;
	for (i in 1:nstates) {
	  tmat[i,] = trans_probs1(i, nstates, s_ad, s_ado, s_juv,
							  p_mv_out, p_mv_in, succ, p_breed,
							  p_rec, p_bead, p_succ)';
	}
	return tmat;
  }

  
  matrix obs_probs(int n_lat_states, int n_obs_states, array[] real p_obs, real p_detect_juv, real p_detect_dead,
				   real p_female, real p_succ, int succ, int no_visit) {

    matrix[n_lat_states, n_obs_states] pmat;

	for (i in 1:n_lat_states) {
	  pmat[i,] = obs_probs1(i, n_obs_states, p_obs, p_detect_juv, p_detect_dead,
							p_female, p_succ, succ, no_visit);
	}
    return pmat;
  }





/* array\[\([^]]*\)\] \([a-z]+\)  → \2[\1]  */
array[] int states_one_indiv_rng (int N_STATES_L, int N_STATES_O, int MAX_T, array[] int NO_VISIT,
							int sex, int first_cap, int first_state, int agefirst,
							array[] int c_hist, array[] int isalive, array[] int b_success,
							array[,] real s_ad, array[] real s_ado, array[] real s_juv,
							array[] real p_moveout, array[] real p_movein, array[,] real p_breeding,
							real age_rec_scale, real age_rec_inflection, real age_br_scale, real age_br_inflection,
							array[] real p_success, int ind, int debug) {

  vector [N_STATES_L] trans_p ;
  array[MAX_T+1] int states;
  array[N_STATES_L] int idx;
  real p_rec;
  real p_bead;
  int age;

  if (debug == 1)  print("in states_one_indiv_rng");

  states[1] = ind;
  if (first_cap > 1) {
	for (t in 1:(first_cap-1)) {
	  states[t+1] = 0;
	}
  }
  states[first_cap+1] = first_state;
  age = agefirst;

  for (i in 1:N_STATES_L) idx[i] = i;
  /* idx = unitspaced_array(1, N_STATES_L); */

  for (t in (first_cap+1):MAX_T) {
	age += 1;
	p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale * (age - age_rec_inflection))));
	p_bead = fmin(1, fmax(0, inv_logit(age_br_scale * (age - age_br_inflection))));

	trans_p = trans_probs1(states[t], N_STATES_L, s_ad[sex+1, t-1], s_ado[t-1], s_juv[t-1],
						   p_moveout[sex+1], p_movein[sex+1], b_success[t-1],
						   p_breeding[,t], p_rec, p_bead, p_success[t-1]);

	if (c_hist[t] == 1) trans_p = [1,0,0,0,0,0,0,0,0]';
	if (c_hist[t] == 2) {
	  trans_p = trans_p .* [0,0,1,0,1,0,0,0,0]';
	  trans_p = trans_p / sum(trans_p);
	}
	/* if (c_hist[t] == 2 & age >= 8) trans_p = [0,0,1,0,0,0,0,0,0]'; */
	/* if (c_hist[t] == 2 & age < 8) trans_p = [0,0,0,0,1,0,0,0,0]'; */
	if (c_hist[t] == 3) {
	  trans_p = trans_p .* [0,1,0,1,0,1,0,0,0]';
	  trans_p = trans_p / sum(trans_p);
	}
	if (c_hist[t] == 4) trans_p = [0,0,0,0,0,0,1,0,0]';
	if (c_hist[t] == 5) trans_p = [0,0,0,0,0,0,0,1,0]';
	if (c_hist[t] == 6) trans_p = [0,0,0,0,0,0,0,0,1]';
	if (isalive[t] == 1) {
	  trans_p = trans_p .* [1,1,1,1,1,1,1,1,0]';
	  trans_p = trans_p / sum(trans_p);
	}

	if (debug == 1) {
	  print("t: ", t);
	  print("ind: ", ind);
	  print("states[t-1]: ", states[t-1]);
	  print("trans_p: ", trans_p);
	  print("N_STATES_L : ", N_STATES_L);
	  print("s_ad[sex+1, t-1] : ", s_ad[sex+1, t-1]);
	  print("s_ado[t-1] : ", s_ado[t-1]);
	  print("s_juv[t-1] : ", s_juv[t-1]);
	  print("p_moveout[sex+1] : ", p_moveout[sex+1]);
	  print("p_movein[sex+1] : ", p_movein[sex+1]);
	  print("b_success[t-1] : ", b_success[t-1]);
	  print("p_breeding[,t] : ", p_breeding[,t]);
	  print("p_rec : ", p_rec);
	  print("p_bead : ", p_bead);
	  print("p_success[t-1] : ", p_success[t-1]);
	}

	/* states[t+1] = to_int(sum(to_vector(idx) .* to_vector(multinomial_rng(trans_p, 1)))); */
	states[t+1] = categorical_rng(trans_p);

  }

  /* } */
  return states;
}


matrix states_multi_indivs_rng (array[] int INDS, int N_INDS, int N_STATES_L, int N_STATES_O, int MAX_T, array[] int NO_VISIT,
								array[] int SEX, array[] int FIRST_CAP, array[] int FIRST_STATE, array[] int AGEFIRST,
								array[,] int C_HIST, array[,] int ISALIVE, array[,] int B_SUCCESS,
								array[,] real s_ad, array[] real s_ado, array[] real s_juv,
								array[] real p_moveout, array[] real p_movein, array[,] real p_breeding,
								real age_rec_scale, real age_rec_inflection, real age_br_scale, real age_br_inflection,
								array[] real p_success, int debug) {

  array[MAX_T+1] int states1;
  matrix[N_INDS, MAX_T+1] allstates;

  if (debug == 1)  print("states_multi_indiv_rng");

  for (ind in 1:N_INDS) {
	states1 = states_one_indiv_rng(N_STATES_L, N_STATES_O, MAX_T, NO_VISIT,
								   SEX[ind], FIRST_CAP[ind], FIRST_STATE[ind], AGEFIRST[ind],
								   C_HIST[ind], ISALIVE[ind], B_SUCCESS[ind],
								   s_ad, s_ado, s_juv, p_moveout, p_movein, p_breeding,
								   age_rec_scale, age_rec_inflection, age_br_scale, age_br_inflection,
								   p_success, ind, debug);
	allstates[ind,] = to_row_vector(states1);
  }

  return allstates;
}


array[,,] int states_multi_indivs_mcmc_rng (array[] int INDS, int N_INDS, int N_STATES_L, int N_STATES_O, int MAX_T, array[] int NO_VISIT,
										  array[] int SEX, array[] int FIRST_CAP, array[] int FIRST_STATE, array[] int AGEFIRST,
										  array[,] int C_HIST, array[,] int ISALIVE, array[,] int B_SUCCESS,
										  array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv,
										  array[,] real p_moveout, array[,] real p_movein, array[,,] real p_breeding,
										  array[] real age_rec_scale, array[] real age_rec_inflection,
										  array[] real age_br_scale, array[] real age_br_inflection,
										  array[,] real p_success, int NSAMPLES, int debug) {

  array[MAX_T+1] int states1;
  array[N_INDS, NSAMPLES, MAX_T+1] int allstates;

  if (debug == 1)  print("states_multi_indiv_mcmc_rng");

  for (smpl in 1:NSAMPLES) {
	for (ind in 1:N_INDS) {
	  states1 = states_one_indiv_rng(N_STATES_L, N_STATES_O, MAX_T, NO_VISIT,
									 SEX[ind], FIRST_CAP[ind], FIRST_STATE[ind], AGEFIRST[ind],
									 C_HIST[ind], ISALIVE[ind], B_SUCCESS[ind],
									 s_ad[,,smpl], s_ado[,smpl], s_juv[,smpl],
									 p_moveout[,smpl], p_movein[,smpl], p_breeding[,,smpl],
									 age_rec_scale[smpl], age_rec_inflection[smpl],
									 age_br_scale[smpl], age_br_inflection[smpl],
									 p_success[,smpl], ind, debug);
	  allstates[ind,smpl,] = states1;
	}
  }

  return allstates;
}


array[,] int states_multi_newinds_mcmc_rng (int NROWS, array[] int NINDS, int N_STATES_L, int N_STATES_O, int MAX_T,
										  array[] int SEX, array[] int FIRST_CAP, array[] int FIRST_STATE, array[] int AGEFIRST, array[] int SAMPLE,
										  array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv,
										  array[,] real p_moveout, array[,] real p_movein, array[,,] real p_breeding,
										  array[] real age_rec_scale, array[] real age_rec_inflection,
										  array[] real age_br_scale, array[] real age_br_inflection,
										  array[,] real p_success, int debug) {

  array[MAX_T+1] int states1;
  array[MAX_T] int chist;
  array[MAX_T] int isalive;
  array[MAX_T] int bsucc;
  array[MAX_T] int novisit;

  array[sum(NINDS), MAX_T+1] int allstates;
  int smpl;

  int indcounter;

  for (t in 1:MAX_T) {
	chist[t] = 0;
	isalive[t] = 0;
	bsucc[t] = 0;
	novisit[t] = 0;
  }
  if (debug == 1)  print("states_multi_newjindiv_mcmc_rng");

  indcounter = 0;

  for (row in 1:NROWS) {
	smpl = SAMPLE[row];
	for (ind in 1:NINDS[row]) {
	  indcounter += 1;
	  states1 = states_one_indiv_rng(N_STATES_L, N_STATES_O, MAX_T, novisit,
									 SEX[row], FIRST_CAP[row], FIRST_STATE[row], AGEFIRST[row],
									 chist, isalive, bsucc,
									 s_ad[,,smpl], s_ado[,smpl], s_juv[,smpl],
									 p_moveout[,smpl], p_movein[,smpl], p_breeding[,,smpl],
									 age_rec_scale[smpl], age_rec_inflection[smpl],
									 age_br_scale[smpl], age_br_inflection[smpl],
									 p_success[,smpl], ind, debug);

	  if (debug == 1) {
		print("============");
		print("smpl: ", smpl);
		print("ind: ", ind);
		print("states1: ", states1);
	  }
	  allstates[indcounter,] = states1;
	}
  }

  return allstates;
}




array[] int states_one_indiv_in_rng (int N_STATES_L, int N_STATES_O, int MAX_T,
								   int sex, int first_cap, int first_state, int agefirst,
								   array[,] real s_ad, array[] real s_ado, array[] real s_juv, array[,] real p_breeding,
								   real age_rec_scale, real age_rec_inflection, real age_br_scale, real age_br_inflection,
								   array[] real p_success, int ind, int debug) {

  vector [N_STATES_L] trans_p ;
  array[MAX_T+1] int states;
  array[N_STATES_L] int idx;
  real p_rec;
  real p_bead;
  int age;

  if (debug == 1)  print("in states_one_indiv_in_rng");

  states[1] = ind;
  if (first_cap > 1) {
	for (t in 1:(first_cap-1)) {
	  states[t+1] = 0;
	}
  }
  states[first_cap+1] = first_state;
  age = agefirst;

  for (i in 1:N_STATES_L) idx[i] = i;
  /* idx = unitspaced_array(1, N_STATES_L); */

  for (t in (first_cap+1):MAX_T) {
	age += 1;
	p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale * (age - age_rec_inflection))));
	p_bead = fmin(1, fmax(0, inv_logit(age_br_scale * (age - age_br_inflection))));

	trans_p = trans_probs1(states[t], N_STATES_L, s_ad[sex+1, t-1], s_ado[t-1], s_juv[t-1],
						   0, 0, 0, p_breeding[,t], p_rec, p_bead, p_success[t-1]);

	/* states[t+1] = to_int(sum(to_vector(idx) .* to_vector(multinomial_rng(trans_p, 1)))); */
	states[t+1] = categorical_rng(trans_p);

  }
  /* 	obs_probs1(int latstate, int n_obs_states, real[] p_obs, real p_detect_juv, real p_detect_dead, */
  /* 			   real p_female, real p_succ, int succ, int no_visit); */


  /* 	tmat = trans_probs(N_STATES_L, ); */
  /* 	pmat = obs_probs(N_STATES_L, N_STATES_O, p_obs[t-1], p_detect_juv, p_detect_dead, p_female, */
  /* 					 p_success[t-1], b_success[t-1], NO_VISIT[t]); */

  /* } */
  return states;
}


array[,,] int states_multi_indivs_mcmc_in_rng (array[] int INDS, int N_INDS, int N_STATES_L, int N_STATES_O, int MAX_T,
											 array[] int SEX, array[] int FIRST_CAP, array[] int FIRST_STATE, array[] int AGEFIRST,
											 array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
											 array[] real age_rec_scale, array[] real age_rec_inflection,
											 array[] real age_br_scale, array[] real age_br_inflection,
											 array[,] real p_success, int NSAMPLES, int debug) {

  array[MAX_T+1] int states1;
  array[N_INDS, NSAMPLES, MAX_T+1] int allstates;

  if (debug == 1)  print("states_multi_indiv_mcmc_in_rng");

  for (smpl in 1:NSAMPLES) {
	for (ind in 1:N_INDS) {
	  states1 = states_one_indiv_in_rng(N_STATES_L, N_STATES_O, MAX_T,
										SEX[ind], FIRST_CAP[ind], FIRST_STATE[ind], AGEFIRST[ind],
										s_ad[,,smpl], s_ado[,smpl], s_juv[,smpl], p_breeding[,,smpl],
										age_rec_scale[smpl], age_rec_inflection[smpl],
										age_br_scale[smpl], age_br_inflection[smpl],
										p_success[,smpl], ind, debug);
	  allstates[ind,smpl,] = states1;
	}
  }

  return allstates;
}


array[,] int states_multi_newinds_mcmc_in_rng (int NROWS, array[] int NINDS, int N_STATES_L, int N_STATES_O, int MAX_T,
											 array[] int SEX, array[] int FIRST_CAP, array[] int FIRST_STATE, array[] int AGEFIRST, array[] int SAMPLE,
											 array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
											 array[] real age_rec_scale, array[] real age_rec_inflection,
											 array[] real age_br_scale, array[] real age_br_inflection,
											 array[,] real p_success, int debug) {

  array[MAX_T+1] int states1;

  array[sum(NINDS), MAX_T+1] int allstates;
  int smpl;

  int indcounter;

  if (debug == 1)  print("states_multi_newjindiv_mcmc_rng");

  indcounter = 0;

  for (row in 1:NROWS) {
	smpl = SAMPLE[row];
	for (ind in 1:NINDS[row]) {
	  indcounter += 1;
	  states1 = states_one_indiv_in_rng(N_STATES_L, N_STATES_O, MAX_T,
										SEX[row], FIRST_CAP[row], FIRST_STATE[row], AGEFIRST[row],
										s_ad[,,smpl], s_ado[,smpl], s_juv[,smpl], p_breeding[,,smpl],
										age_rec_scale[smpl], age_rec_inflection[smpl],
										age_br_scale[smpl], age_br_inflection[smpl],
										p_success[,smpl], ind, debug);

	  if (debug == 1) {
		print("============");
		print("smpl: ", smpl);
		print("ind: ", ind);
		print("states1: ", states1);
	  }
	  allstates[indcounter,] = states1;
	}
  }

  return allstates;
}




array[,,] int states_full_from_init0_rng (int NROWS, int MAX_T, int NSAMPLES,
									  array[] int FIRST_STATE, array[] int SEX, array[] int FIRST_AGE, array[] int NINDS,
									  array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
									  array[] real age_rec_scale, array[] real age_rec_inflection,
										array[] real age_br_scale, array[] real age_br_inflection,
									  array[,] real p_success, array[] real p_female, int N_STATES_L, int BUFFEREDROWS, int debug) {

  array[NSAMPLES, BUFFEREDROWS, MAX_T + 7] int results = rep_array(0, NSAMPLES, BUFFEREDROWS, MAX_T + 7);

  /* int states1 [MAX_T+3]; */
  /* int allstates [sum(NINDS), MAX_T+1]; */
  /* int smpl; */

  int popcounter = 0;				/* counter across the population */

  real p_rec;
  real p_bead;

  int newstate;
  int prevstate;

  int npairs;
  int nbreedf;
  int nbreedm;
  int njuvs;
  int njuvsf;
  int njuvsm;

  int age;
  int sex;

  vector [N_STATES_L] trans_p ;

  if (debug == 1)  print("states_full_from_inti_rng");

  for (sample in 1:NSAMPLES) {

	if (debug == 1)  print("sample: ", sample);

	/* ** Initialisation - year 1 */
	popcounter = 0;
	for (row in 1:NROWS) {
	  /* indrow = 0; */
	  for (i in 1:NINDS[row]) {
		/* indrow += 1; */
		popcounter += 1;
		results[sample, popcounter, 1] = sample;
		results[sample, popcounter, 2] = popcounter;
		results[sample, popcounter, 3] = SEX[row];
		results[sample, popcounter, 4] = FIRST_AGE[row]; /* remains first age */
		results[sample, popcounter, 5] = FIRST_AGE[row]; /* age counter */
		results[sample, popcounter, 6] = 0; /* cohort */
		results[sample, popcounter, 7] = FIRST_STATE[row];
	  }
	}

	if (debug == 1)  print("after initialisation, popcounter: ", popcounter);

	/* ** Loop over years */
	for (year in 2:(MAX_T+1)) {
	  nbreedf = 0;
	  nbreedm = 0;
	  njuvs = 0;
	  njuvsf = 0;
	  njuvsm = 0;

	  /* *** Transition from previous year */
	  for (ind in 1:popcounter) {
		prevstate = results[sample, ind, year + 5];
		if (prevstate != 9 && prevstate != 0) {
		  results[sample, ind, 5] += 1; /* increment age */
		  sex = results[sample, ind, 3];
		  age = results[sample, ind, 5];
		  p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale[sample] * (age - age_rec_inflection[sample]))));
		  p_bead = fmin(1, fmax(0, inv_logit(age_br_scale[sample] * (age - age_br_inflection[sample]))));

		  trans_p = trans_probs1(prevstate, N_STATES_L,
								 s_ad[sex + 1, year - 1, sample],
								 s_ado[year - 1, sample], s_juv[year - 1, sample],
								 0, 0, 0, p_breeding[, year, sample], p_rec, p_bead, p_success[year - 1, sample]);

		  newstate = categorical_rng(trans_p);

		  /* Keep track of breeders */
		  if (newstate == 1) {
			if (sex == 1) {
			  nbreedf += 1;
			} else nbreedm += 1;
		  }
		  results[sample, ind, year + 6] = newstate;
		}
	  }

	  /* *** Breeding -> add juveniles */
	  npairs = nbreedf <= nbreedm ? nbreedf : nbreedm;
	  njuvs = binomial_rng(npairs, p_success[year, sample]);
	  for (juv in 1:njuvs) {
		popcounter += 1;
		results[sample, popcounter, 1] = sample;
		results[sample, popcounter, 2] = popcounter;
		results[sample, popcounter, 3] = bernoulli_rng(p_female[sample]) + 1;
		results[sample, popcounter, 4] = 0;
		results[sample, popcounter, 5] = 0;
		results[sample, popcounter, 6] = year - 1; /* cohort */
		results[sample, popcounter, year + 6] = 7;
	  }
	}
  }
  return results;
}




array[,] int states_full_from_init_rng (int NROWS, int MAX_T, int NSAMPLES,
									  array[] int FIRST_STATE, array[] int SEX, array[] int FIRST_AGE, array[] int NINDS,
									  array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
									  array[] real age_rec_scale, array[] real age_rec_inflection,
									  array[] real age_br_scale, array[] real age_br_inflection,
									  array[,] real p_success, array[] real p_female, int N_STATES_L, int BUFFEREDROWS, int debug) {

  /* int results [NSAMPLES, BUFFEREDROWS, MAX_T + 7] = rep_array(0, NSAMPLES, BUFFEREDROWS, MAX_T + 7); */
  array[NSAMPLES*BUFFEREDROWS, MAX_T + 7] int results = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7);

  /* int states1 [MAX_T+3]; */
  /* int allstates [sum(NINDS), MAX_T+1]; */
  /* int smpl; */

  int popcounter = 0;				/* counter across the population */
  int startrow = 0;					/* starting row for new sample individuals */

  real p_rec;
  real p_bead;

  int newstate;
  int prevstate;

  int npairs;
  int nbreedf;
  int nbreedm;
  int njuvs;
  int njuvsf;
  int njuvsm;

  int age;
  int sex;

  vector [N_STATES_L] trans_p ;

  if (debug == 1)  print("states_full_from_inti_rng");

  for (sample in 1:NSAMPLES) {

	startrow = popcounter;

	/* ** Initialisation - year 1 */
	popcounter = 0;
	for (row in 1:NROWS) {
	  /* indrow = 0; */
	  for (i in 1:NINDS[row]) {
		/* indrow += 1; */
		popcounter += 1;
		results[startrow + popcounter, 1] = sample;
		results[startrow + popcounter, 2] = popcounter;
		results[startrow + popcounter, 3] = SEX[row];
		results[startrow + popcounter, 4] = FIRST_AGE[row]; /* remains first age */
		results[startrow + popcounter, 5] = FIRST_AGE[row]; /* age counter */
		results[startrow + popcounter, 6] = 0; /* cohort */
		results[startrow + popcounter, 7] = FIRST_STATE[row];
	  }
	}

	/* ** Loop over years */
	for (year in 2:(MAX_T+1)) {
	  nbreedf = 0;
	  nbreedm = 0;
	  njuvs = 0;
	  njuvsf = 0;
	  njuvsm = 0;

	  /* *** Transition from previous year */
	  for (ind in 1:popcounter) {
		prevstate = results[startrow + ind, year + 5];
		if (prevstate != 9 && prevstate != 0) {
		  results[startrow + ind, 5] += 1; /* increment age */
		  sex = results[startrow + ind, 3];
		  age = results[startrow + ind, 5];
		  p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale[sample] * (age - age_rec_inflection[sample]))));
		  p_bead = fmin(1, fmax(0, inv_logit(age_br_scale[sample] * (age - age_br_inflection[sample]))));

		  trans_p = trans_probs1(prevstate, N_STATES_L,
								 s_ad[sex + 1, year - 1, sample],
								 s_ado[year - 1, sample], s_juv[year - 1, sample],
								 0, 0, 0, p_breeding[, year, sample], p_rec, p_bead, p_success[year - 1, sample]);

		  newstate = categorical_rng(trans_p);

		  /* Keep track of breeders */
		  if (newstate == 1) {
			if (sex == 1) {
			  nbreedf += 1;
			} else nbreedm += 1;
		  }
		  results[startrow + ind, year + 6] = newstate;
		}
	  }

	  /* *** Breeding -> add juveniles */
	  npairs = nbreedf <= nbreedm ? nbreedf : nbreedm;
	  njuvs = binomial_rng(npairs, p_success[year, sample]);
	  for (juv in 1:njuvs) {
		popcounter += 1;
		results[startrow + popcounter, 1] = sample;
		results[startrow + popcounter, 2] = popcounter;
		results[startrow + popcounter, 3] = bernoulli_rng(p_female[sample]) + 1;
		results[startrow + popcounter, 4] = 0;
		results[startrow + popcounter, 5] = 0;
		results[startrow + popcounter, 6] = year - 1; /* cohort */
		results[startrow + popcounter, year + 6] = 7;
	  }
	}
  }
  return results;
}


matrix states_full_from_init2_rng (int NROWS, int MAX_T, int NSAMPLES,
									  array[] int FIRST_STATE, array[] int SEX, array[] int FIRST_AGE, array[] int NINDS,
									  array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
									  array[] real age_rec_scale, array[] real age_rec_inflection,
									   array[] real age_br_scale, array[] real age_br_inflection,
									  array[,] real p_success, array[] real p_female, int N_STATES_L, int BUFFEREDROWS, int debug) {

  /* int results [NSAMPLES, BUFFEREDROWS, MAX_T + 7] = rep_array(0, NSAMPLES, BUFFEREDROWS, MAX_T + 7); */
  /* int results [NSAMPLES*BUFFEREDROWS, MAX_T + 7] = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7); */
  /* matrix [NSAMPLES*BUFFEREDROWS, MAX_T + 7] results  = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7); */
  matrix [NSAMPLES*BUFFEREDROWS, MAX_T + 7] results  = rep_matrix(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7);

  /* int states1 [MAX_T+3]; */
  /* int allstates [sum(NINDS), MAX_T+1]; */
  /* int smpl; */

  int popcounter = 0;				/* counter across the population */
  int startrow = 0;					/* starting row for new sample individuals */

  array[BUFFEREDROWS, MAX_T + 7] int sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 7);
  /* matrix [BUFFEREDROWS, MAX_T + 7] sampleres = rep_matrix(0, BUFFEREDROWS, MAX_T + 7); */

  real p_rec;
  real p_bead;

  int newstate;
  int prevstate;

  int npairs;
  int nbreedf;
  int nbreedm;
  int njuvs;
  int njuvsf;
  int njuvsm;

  int age;
  int sex;

  vector [N_STATES_L] trans_p ;

  if (debug == 1)  print("states_full_from_inti_rng");

  for (sample in 1:NSAMPLES) {

	if (debug == 1)  print("* sample: ", sample);

	sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 7);

	startrow += popcounter + 1;

	if (debug == 1) print("    startrow: ", startrow);

	/* ** Initialisation - year 1 */
	popcounter = 0;
	for (row in 1:NROWS) {
	  /* indrow = 0; */
	  for (i in 1:NINDS[row]) {
		/* indrow += 1; */
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = SEX[row];
		sampleres[popcounter, 4] = FIRST_AGE[row]; /* remains first age */
		sampleres[popcounter, 5] = FIRST_AGE[row]; /* age counter */
		sampleres[popcounter, 6] = 0; /* cohort */
		sampleres[popcounter, 7] = FIRST_STATE[row];
	  }
	}

	/* ** Loop over years */
	for (year in 2:(MAX_T+1)) {
	  nbreedf = 0;
	  nbreedm = 0;
	  njuvs = 0;
	  njuvsf = 0;
	  njuvsm = 0;

	  /* *** Transition from previous year */
	  for (ind in 1:popcounter) {
		prevstate = sampleres[ind, year + 5];
		if (prevstate != 9 && prevstate != 0) {
		  sampleres[ind, 5] += 1; /* increment age */
		  sex = sampleres[ind, 3];
		  age = sampleres[ind, 5];
		  p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale[sample] * (age - age_rec_inflection[sample]))));
		  p_bead = fmin(1, fmax(0, inv_logit(age_br_scale[sample] * (age - age_br_inflection[sample]))));

		  trans_p = trans_probs1(prevstate, N_STATES_L,
								 s_ad[sex + 1, year - 1, sample],
								 s_ado[year - 1, sample], s_juv[year - 1, sample],
								 0, 0, 0, p_breeding[, year, sample], p_rec, p_bead, p_success[year - 1, sample]);

		  newstate = categorical_rng(trans_p);

		  /* Keep track of breeders */
		  if (newstate == 1) {
			if (sex == 1) {
			  nbreedf += 1;
			} else nbreedm += 1;
		  }
		  sampleres[ind, year + 6] = newstate;
		}
	  }

	  /* *** Breeding -> add juveniles */
	  npairs = nbreedf <= nbreedm ? nbreedf : nbreedm;
	  njuvs = binomial_rng(npairs, p_success[year, sample]);
	  for (juv in 1:njuvs) {
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = bernoulli_rng(p_female[sample]) + 1;
		sampleres[popcounter, 4] = 0;
		sampleres[popcounter, 5] = 0;
		sampleres[popcounter, 6] = year - 1; /* cohort */
		sampleres[popcounter, year + 6] = 7;
	  }
	}

	if (debug == 1) print("  popcounter: ", popcounter);

	results[startrow:(startrow + popcounter - 1),] = to_matrix(sampleres[1:popcounter]);
	/* results = append_row(results, sampleres[1:popcounter,]); */
	/* results[startrow:(startrow+BUFFEREDROWS),] = sampleres; */

  }

  return results[1:(startrow + popcounter - 1),];

}



array[,] int states_full_from_init3_rng (int NROWS, int MAX_T, int NSAMPLES,
									   array[] int FIRST_STATE, array[] int SEX, array[] int FIRST_AGE, array[] int NINDS,
									   array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
									   array[] real age_rec_scale, array[] real age_rec_inflection,
									   array[] real age_br_scale, array[] real age_br_inflection,
									   array[,] real p_success, array[] real p_female, int N_STATES_L, int BUFFEREDROWS, int debug) {

  /* int results [NSAMPLES, BUFFEREDROWS, MAX_T + 7] = rep_array(0, NSAMPLES, BUFFEREDROWS, MAX_T + 7); */
  /* int results [NSAMPLES*BUFFEREDROWS, MAX_T + 7] = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7); */
  /* matrix [NSAMPLES*BUFFEREDROWS, MAX_T + 7] results  = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7); */
  array[NSAMPLES*BUFFEREDROWS, MAX_T + 7] int results = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 7);

  /* int states1 [MAX_T+3]; */
  /* int allstates [sum(NINDS), MAX_T+1]; */
  /* int smpl; */

  int popcounter = 0;				/* counter across the population */
  int startrow = 0;					/* starting row for new sample individuals */

  array[BUFFEREDROWS, MAX_T + 7] int sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 7);
  /* matrix [BUFFEREDROWS, MAX_T + 7] sampleres = rep_matrix(0, BUFFEREDROWS, MAX_T + 7); */

  real p_rec;
  real p_bead;

  int newstate;
  int prevstate;

  int npairs;
  int nbreedf;
  int nbreedm;
  int njuvs;
  int njuvsf;
  int njuvsm;

  int age;
  int sex;

  vector [N_STATES_L] trans_p ;

  if (debug == 1)  print("states_full_from_init3_rng");

  for (sample in 1:NSAMPLES) {

	if (debug == 1)  print("* sample: ", sample);

	sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 7);

	startrow += popcounter + 1;

	if (debug == 1) print("    startrow: ", startrow);

	/* ** Initialisation - year 1 */
	popcounter = 0;
	for (row in 1:NROWS) {
	  /* indrow = 0; */
	  for (i in 1:NINDS[row]) {
		/* indrow += 1; */
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = SEX[row];
		sampleres[popcounter, 4] = FIRST_AGE[row]; /* remains first age */
		sampleres[popcounter, 5] = FIRST_AGE[row]; /* age counter */
		sampleres[popcounter, 6] = 0; /* cohort */
		sampleres[popcounter, 7] = FIRST_STATE[row];
	  }
	}

	if (debug == 1) print("    Done with initialisation.");

	/* ** Loop over years */
	for (year in 2:(MAX_T+1)) {
	  if (debug == 1) print("    Year ", year);

	  nbreedf = 0;
	  nbreedm = 0;
	  njuvs = 0;
	  njuvsf = 0;
	  njuvsm = 0;

	  /* *** Transition from previous year */
	  for (ind in 1:popcounter) {
		prevstate = sampleres[ind, year + 5];
		if (prevstate != 9 && prevstate != 0) {
		  sampleres[ind, 5] += 1; /* increment age */
		  sex = sampleres[ind, 3];
		  age = sampleres[ind, 5];
		  p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale[sample] * (age - age_rec_inflection[sample]))));
		  p_bead = fmin(1, fmax(0, inv_logit(age_br_scale[sample] * (age - age_br_inflection[sample]))));

		  trans_p = trans_probs1(prevstate, N_STATES_L,
								 s_ad[sex + 1, year - 1, sample],
								 s_ado[year - 1, sample], s_juv[year - 1, sample],
								 0, 0, 0, p_breeding[, year, sample], p_rec, p_bead, p_success[year - 1, sample]);

		  newstate = categorical_rng(trans_p);

		  /* Keep track of breeders */
		  if (newstate == 1) {
			if (sex == 1) {
			  nbreedf += 1;
			} else nbreedm += 1;
		  }
		  sampleres[ind, year + 6] = newstate;
		}
	  }

	  /* *** Breeding -> add juveniles */
	  npairs = nbreedf <= nbreedm ? nbreedf : nbreedm;
	  njuvs = binomial_rng(npairs, p_success[year, sample]);
	  for (juv in 1:njuvs) {
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = bernoulli_rng(p_female[sample]) + 1;
		sampleres[popcounter, 4] = 0;
		sampleres[popcounter, 5] = 0;
		sampleres[popcounter, 6] = year - 1; /* cohort */
		sampleres[popcounter, year + 6] = 7;
	  }
	}

	if (debug == 1) print("  popcounter: ", popcounter);

	results[startrow:(startrow + popcounter - 1),] = sampleres[1:popcounter];
	/* results = append_row(results, sampleres[1:popcounter,]); */
	/* results[startrow:(startrow+BUFFEREDROWS),] = sampleres; */

  }

  return results[1:(startrow + popcounter - 1),];

}



array[,] int states_full_from_init4_rng (int NROWS, int MAX_T, int NSAMPLES,
									   array[] int FIRST_STATE, array[] int SEX, array[] int FIRST_AGE, array[] int NINDS,
									   array[,,] real s_ad, array[,] real s_ado, array[,] real s_juv, array[,,] real p_breeding,
									   array[] real age_rec_scale, array[] real age_rec_inflection,
									   array[] real age_br_scale, array[] real age_br_inflection,
									   array[,] real p_success, array[] real p_female, int N_STATES_L, int BUFFEREDROWS, int debug) {

  /* int results [NSAMPLES, BUFFEREDROWS, MAX_T + 8] = rep_array(0, NSAMPLES, BUFFEREDROWS, MAX_T + 8); */
  /* int results [NSAMPLES*BUFFEREDROWS, MAX_T + 8] = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 8); */
  /* matrix [NSAMPLES*BUFFEREDROWS, MAX_T + 8] results  = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 8); */
  array[NSAMPLES*BUFFEREDROWS, MAX_T + 8] int results = rep_array(0, NSAMPLES*BUFFEREDROWS, MAX_T + 8);

  /* int states1 [MAX_T+3]; */
  /* int allstates [sum(NINDS), MAX_T+1]; */
  /* int smpl; */

  int popcounter = 0;				/* counter across the population */
  int startrow = 0;					/* starting row for new sample individuals */

  array[BUFFEREDROWS, MAX_T + 8] int sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 8);
  /* matrix [BUFFEREDROWS, MAX_T + 8] sampleres = rep_matrix(0, BUFFEREDROWS, MAX_T + 8); */

  real p_rec;
  real p_bead;

  int newstate;
  int prevstate;

  int npairs;
  int nbreedf;
  int nbreedm;
  int njuvs;
  int njuvsf;
  int njuvsm;

  int age;
  int sex;

  vector [N_STATES_L] trans_p ;

  if (debug == 1)  print("states_full_from_inti_rng");

  for (sample in 1:NSAMPLES) {

	if (debug == 1)  print("* sample: ", sample);

	sampleres = rep_array(0, BUFFEREDROWS, MAX_T + 8);

	startrow += popcounter + 1;

	if (debug == 1) print("    startrow: ", startrow);

	/* ** Initialisation - year 1 */
	popcounter = 0;
	for (row in 1:NROWS) {
	  /* indrow = 0; */
	  for (i in 1:NINDS[row]) {
		/* indrow += 1; */
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = SEX[row];
		sampleres[popcounter, 4] = FIRST_AGE[row]; /* remains first age */
		sampleres[popcounter, 5] = FIRST_AGE[row]; /* age counter */
		sampleres[popcounter, 6] = 0; /* cohort */
		sampleres[popcounter, 7] = FIRST_STATE[row];
		sampleres[popcounter, 8] = 0; /* b success */
	  }
	}

	/* ** Loop over years */
	for (year in 2:(MAX_T+1)) {
	  nbreedf = 0;
	  nbreedm = 0;
	  njuvs = 0;
	  njuvsf = 0;
	  njuvsm = 0;

	  /* *** Transition from previous year */
	  for (ind in 1:popcounter) {
		prevstate = sampleres[ind, year + 5];
		if (prevstate != 9 && prevstate != 0) {
		  sampleres[ind, 5] += 1; /* increment age */
		  sex = sampleres[ind, 3];
		  age = sampleres[ind, 5];
		  p_rec = fmin(1, fmax(0, inv_logit(age_rec_scale[sample] * (age - age_rec_inflection[sample]))));
		  p_bead = fmin(1, fmax(0, inv_logit(age_br_scale[sample] * (age - age_br_inflection[sample]))));

		  trans_p = trans_probs1(prevstate, N_STATES_L,
								 s_ad[sex + 1, year - 1, sample],
								 s_ado[year - 1, sample], s_juv[year - 1, sample],
								 0, 0, 0, p_breeding[, year, sample], p_rec, p_bead, p_success[year - 1, sample]);

		  newstate = categorical_rng(trans_p);

		  /* Keep track of breeders */
		  if (newstate == 1) {
			if (sex == 1) {
			  nbreedf += 1;
			} else nbreedm += 1;
		  }
		  sampleres[ind, year + 6] = newstate;
		}
	  }

	  /* *** Breeding -> add juveniles */
	  npairs = nbreedf <= nbreedm ? nbreedf : nbreedm;
	  njuvs = binomial_rng(npairs, p_success[year, sample]);
	  for (juv in 1:njuvs) {
		popcounter += 1;
		sampleres[popcounter, 1] = sample;
		sampleres[popcounter, 2] = popcounter;
		sampleres[popcounter, 3] = bernoulli_rng(p_female[sample]) + 1;
		sampleres[popcounter, 4] = 0;
		sampleres[popcounter, 5] = 0;
		sampleres[popcounter, 6] = year - 1; /* cohort */
		sampleres[popcounter, year + 6] = 7;
	  }
	}

	if (debug == 1) print("  popcounter: ", popcounter);

	results[startrow:(startrow + popcounter - 1),] = sampleres[1:popcounter];
	/* results = append_row(results, sampleres[1:popcounter,]); */
	/* results[startrow:(startrow+BUFFEREDROWS),] = sampleres; */

  }

  return results[1:(startrow + popcounter - 1),];

}

array[] int viterbi_path_one_indiv (int N_STATES_L, int N_STATES_O, int sex, array[] int age, int MAX_T,
				    int first_cap, int last_cap,
array[] int c_hist, array[,] real s_ad, array[] real s_ado,
                                      array[] real s_juv, array[] real p_moveout,
                                      array[] real p_movein, array[] int b_success, array[,] real p_breeding,
                                      real age_rec_inflection, real age_rec_scale, real age_br_inflection, real age_br_scale,
                                      array[] real p_success, array[,] real p_obs,
                                      real p_detect_juv, real p_detect_dead, real p_female, array[] int NO_VISIT,
                                      int first_state) {

    matrix[N_STATES_L, N_STATES_L] tmat;
    matrix[N_STATES_L, N_STATES_O] pmat;
    
    // log_p tracks the max log-probability of reaching state j at time t
    matrix[MAX_T, N_STATES_L] log_p = rep_matrix(negative_infinity(), MAX_T, N_STATES_L);
    // back_ptr tracks which state at t-1 led to that max probability
    array[MAX_T, N_STATES_L] int back_ptr;
    // The final returned path
    array[MAX_T] int best_path = rep_array(0, MAX_T);
    
    real p_rec;
    real p_bead;

    // 1. INITIALIZATION
    log_p[first_cap, first_state] = 0.0;
    best_path[first_cap] = first_state;

    // 2. FORWARD PASS (Finding max probabilities)
    if (last_cap > first_cap) {
      for (t in (first_cap+1):last_cap) {
        
        p_rec = inv_logit(age_rec_scale * (age[t] - age_rec_inflection));
        p_bead = inv_logit(age_br_scale * (age[t] - age_br_inflection));
        
        tmat = trans_probs(N_STATES_L, s_ad[sex+1, t-1], s_ado[t-1], s_juv[t-1],
                           p_moveout[sex+1], p_movein[sex+1], b_success[t-1],
                           p_breeding[,t], p_rec, p_bead, p_success[t-1]);
                           
        pmat = obs_probs(N_STATES_L, N_STATES_O, p_obs[t-1], p_detect_juv, p_detect_dead, p_female,
                         p_success[t-1], b_success[t-1], NO_VISIT[t]);

        for (j in 1:N_STATES_L) {
          real best_logp = negative_infinity();
          int best_i = 1;
          
          for (i in 1:N_STATES_L) {
            // Calculate joint probability: p(state t-1) * p(transition) * p(observation)
            real current_logp = log_p[t-1, i] + log(tmat[i, j] + 1e-15) + log(pmat[j, c_hist[t]] + 1e-15);
            
            if (current_logp > best_logp) {
              best_logp = current_logp;
              best_i = i; // Save the argmax
            }
          }
          log_p[t, j] = best_logp;
          back_ptr[t, j] = best_i;
        }
      }
      
      // 3. BACKWARD PASS (Tracing the best path via backpointers)
      real max_final_logp = negative_infinity();
      int final_best_state = 1;
      
      // Find the most likely state at the very last capture
      for (j in 1:N_STATES_L) {
        if (log_p[last_cap, j] > max_final_logp) {
          max_final_logp = log_p[last_cap, j];
          final_best_state = j;
        }
      }
      best_path[last_cap] = final_best_state;
      
      // Trace backwards using the pointers
      for (t in 1:(last_cap - first_cap - 1)) {
        int rev_t = last_cap - t;
        best_path[rev_t] = back_ptr[rev_t+1, best_path[rev_t+1]];
      }
    }

    return best_path;
  }



}
