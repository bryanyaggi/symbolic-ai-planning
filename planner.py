#!/usr/bin/env python3

#import networkx as nx
#import matplotlib.pyplot as plt
from pyperplan.task import Task
from pyperplan.planner import search
from pyperplan.heuristics.blind import BlindHeuristic
from pyperplan.pddl import Parser

def solve_pddl(domain_file, problem_file):
    # Parse domain and problem files
    domain = parse_domain(domain_file)
    problem = parse_problem(problem_file)

    # Create a task
    task = Task(domain, problem)

    # Solve the task using a blind heuristic
    solution = search(task, BlindHeuristic(task))

    # Print the solution
    print("Solution:")
    for step in solution:
        print(step)
    
    '''
    # Create a directed graph
    G = nx.DiGraph()
    
    # Add nodes and edges based on solution
    prev_state = "Start"
    G.add_node(prev_state)
    for i, action in enumerate(solution):
        action_name = f"{i+1}: {action}"
        G.add_node(action_name)
        G.add_edge(prev_state, action_name)
        prev_state = action_name
    
    # Draw the graph
    plt.figure(figsize=(10, 6))
    pos = nx.spring_layout(G)
    nx.draw(G, pos, with_labels=True, node_color='lightblue', edge_color='gray', node_size=3000, font_size=10)
    plt.title("PDDL Plan Visualization")
    plt.show()
    '''

if __name__ == "__main__":
    solve_pddl("roadDomain.pddl", "roadProblem.pddl")
