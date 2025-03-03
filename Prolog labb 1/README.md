# DD1351 - Logics for Computer Scientists  
## Lab 1 - Logic Programming  

### Overview  
This lab introduces **logic programming** using **Prolog**. The goal is to develop an understanding of unification, recursion, backtracking, and graph representation.  

### Tasks  

#### 1. Unification (4p)  
- Analyze the behavior of the Prolog system when given a specific query.  
- Explain the resulting variable bindings.  

#### 2. Representation (6p)  
- Implement `remove_duplicates/2`, which removes duplicate elements from a list while maintaining order.  
- Explain why this predicate behaves as a function.  

#### 3. Recursion & Backtracking (6p)  
- Implement `partstring/3`, which extracts consecutive sublists of a given length from a list.  
- Ensure multiple solutions are generated using backtracking.  

#### 4. Graph Representation & Pathfinding (8p)  
- Define a representation for graphs where each node has a unique name and lists its neighbors.  
- Implement a pathfinding algorithm that finds paths from node **A** to node **B** without revisiting nodes.  
- Ensure multiple paths can be retrieved via backtracking.  

### Bonus Task (Optional)  
- Design a Prolog program that forms a **stable government** based on seat counts and party compatibility.  

### Technologies Used  
- **Programming Language:** Prolog  
- **Development Tools:** Any Prolog-compatible environment (e.g., SWI-Prolog, GNU Prolog)  

### Running the Code  
1. Install **SWI-Prolog** (or another Prolog interpreter).  
2. Load the Prolog file:  
   ```prolog
   ?- consult('lab1.pl').
3. Run individual predicates for testing.
