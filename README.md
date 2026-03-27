OVERVIEW:
- This repository contains:
(1) data from human participants (N = 42) completing a reward learning study with an effort manipulation. One group completed the task on 800 mg sulpiride (dopamine D2 receptor antagonist), and a separate group on placebo.
(2) matlab functions to run computational models of reinforcement learning.
- Full details of these data and models are provided in 'Dopamine D2-receptor blockade in humans disrupts the effect of effort on learning' (Jarvis et al. 2026, PLOS Biology).


DATA FILE: data-behaviour-sulpiride-effort-learning
- DESCRIPTION: behavioural data and task conditions, long form (one trial per row)
- VARIABLES:
     - id: 3-digit participant ID
     - choice: 1 = low effort stimulus, 2 = high effort stimulus
     - outcome: 0 = no reward, 1 = reward
     - correct: 0 = chose low value stimulus, 1 = chose high value stimulus
     - condition: 1 = P(stim 1) = 0.7, P(stim 2) = 0.3;
                  2 = P(stim 1) = 0.3, P(stim 2) = 0.7;
                  3 = P(stim 1) = 0.3, P(stim 2) = 0.3;
                  4 = P(stim 1) = 0.7, P(stim 2) = 0.7.
     - block: 1 or 2
     - session: 1 = first session
     - drug: 0 = placebo, 1 = sulpiride
     - effort: force exerted in MVC
     - trial: current trial number


DATA FILE: data-subjects-sulpiride-effort-learning
- DESCRIPTION: subject data with vitals and BLVAS ratings, short form (one subject per row)
- VARIABLES:
     - id: 3-digit participant ID
     - drug: 0 = placebo, 1 = sulpiride
     - guess: 0 = placebo, 1 = sulpiride, 2 = unsure
     - gender: 0 = female, 1 = male
     - age: in years
     - height: in metres
     - weight: in kg
     - HR: heart rate (_0 to _4 hours since drug ingestion)
     - BP_S: blood pressure, systolic (_0 to _4 hours since drug ingestion)
     - BP_D: blood pressure, diastolic (_0 to _4 hours since drug ingestion)
     - drowsy: BLVAS alert/drowsy (_0 to _4 hours since drug ingestion)
     - feeble: BLVAS strong/feeble (_0 to _4 hours since drug ingestion)
     - energetic: BLVAS lethargic/energetic (_0 to _4 hours since drug ingestion)
     - alertness: BLVAS alertness (_0 to _4 hours since drug ingestion)
     - contentedness: BLVAS contentedness (_0 to _4 hours since drug ingestion)
     - calmness: BLVAS calmness (_0 to _4 hours since drug ingestion)

MATLAB FUNCTIONS: fn_M1_baseline, fn_M2_dual_learning_rates, fn_M3_effort_reinforcement
- DESCRIPTION:
     - matlab code for three separate computational models of reinforcement learning (M1-3).
     - M1 is the baseline model (single learning rate)
     - M2 is the dual learning rates model (learning rate asymmetry)
     - M3 is the effort reinforcement model (learning rate asymmetry sensitive to effort)
     - models can be fit to trial-by-trial choice data by using e.g. fmincon() to minimise the negative log likelihood
