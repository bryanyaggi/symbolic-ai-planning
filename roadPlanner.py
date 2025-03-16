#! /usr/bin/env python3

from owlready2 import *
from collections import deque
import os

import unittest

class RoadProblem:
    def __init__(self, ontoFile="road.rdf"):
        self.onto = get_ontology(ontoFile).load()
        self.createIndividuals()
        sync_reasoner_pellet() # do not infer property and data property values
        self.roadWithIndividuals = "roadWithIndividuals.rdf"
        if os.path.exists(self.roadWithIndividuals):
            os.remove(self.roadWithIndividuals)
        self.onto.save(self.roadWithIndividuals) # file will be used to initialize new worlds

    def createIndividuals(self):
        """Create individuals for the problem"""
        # Environment
        roadsec1 = self.onto.RoadSection("roadsec1")
        roadsec2 = self.onto.RoadSection("roadsec2")
        roadsec3 = self.onto.RoadSection("roadsec3")
        roadsec2.adjacentTo = [roadsec1, roadsec3]
        roadsec1.isClear = True
        roadsec2.isClear = False
        roadsec3.isClear = True
        self.roadsecNames = [roadsec1.name, roadsec2.name, roadsec3.name]

        # Agents
        robot1 = self.onto.Robot("robot1")
        robot2 = self.onto.Bulldozer("robot2")
        robot1.at = roadsec1
        robot2.at = roadsec1
        self.agentNames = [robot1.name, robot2.name]
        
        self.stateIndices = {}
        for i in range(len(self.agentNames)):
            self.stateIndices[self.agentNames[i]] = i
        for i in range(len(self.roadsecNames)):
            self.stateIndices[self.roadsecNames[i]] = i + len(self.agentNames)  
        self.stateInitial = self.getState()
        print(self.stateInitial)

    def getState(self):
        return [self.onto.Agent(name).at.name for name in self.agentNames] + \
            [self.onto.RoadSection(name).isClear for name in self.roadsecNames]

    def updateOntoFromState(self, state):
        newWorld = World()
        self.onto = newWorld.get_ontology(self.roadWithIndividuals).load()
        for i in range(len(self.agentNames)):
            self.onto.Agent(self.agentNames[i]).at = self.onto.RoadSection(state[i])
        for i in range(len(self.roadsecNames)):
            self.onto.RoadSection(self.roadsecNames[i]).isClear = state[i + len(self.agentNames)]
        sync_reasoner_pellet(newWorld, infer_property_values=True, infer_data_property_values=True, debug=0)
    
    def goalReached(self, state):
        return state[0] == "roadsec3"

    def getActions(self):
        actions = {}
        for agentName in self.agentNames:
            actions[agentName] = []
            if self.onto.Agent(agentName).canMove:
                for roadsec in (self.onto.Agent(agentName).at).adjacentTo:
                    actions[agentName].append(("move", roadsec.name))
            if self.onto.Agent(agentName).canClear:
                actions[agentName].append(("clear",))
        return actions
     
    def getNextStateFromAction(self, state, agentName, action):
        nextState = state.copy()
        if action[0] == "move":
            nextState[self.stateIndices[agentName]] = action[1]
        elif action[0] == "clear":
            roadsecIndex = self.stateIndices[self.onto.Agent(agentName).at.name]
            nextState[roadsecIndex] = True
        return nextState

    def bfs(self):
        queue = deque([self.stateInitial])
        visited = set()
        history = {tuple(self.stateInitial): (None, None, None)}

        def getHistory(stateTuple):
            path = []
            actions = []
            while stateTuple:
                path.append(stateTuple)
                if history[stateTuple][1] is not None:
                    actions.append(tuple(history[stateTuple][1:]))
                stateTuple = history[stateTuple][0]
            return path[::-1], actions[::-1]

        while queue:
            state = queue.popleft()
            print("Expanding node: %s" %state)

            if self.goalReached(state):
                print("Goal reached")
                path, actions = getHistory(tuple(state))
                print("Path: %s" %path)
                print("Actions: %s" %actions)
                return
            
            self.updateOntoFromState(state)
            actions = self.getActions()
            for agentName in self.agentNames:
                for action in actions[agentName]:
                    nextState = self.getNextStateFromAction(state, agentName, action)
                    #print("agentName: %s, action: %s, nextState: %s" %(agentName, action, nextState))
                    if tuple(nextState) not in visited:
                        visited.add(tuple(nextState))
                        history[tuple(nextState)] = (tuple(state), agentName, action[0])
                        queue.append(nextState)
        
        print("No solution found")

class TestRoadProblem(unittest.TestCase):
    def setUp(self):
        self.rp = RoadProblem()

    def testUpdateOntoFromState(self):
        print(self.rp.getState())
        state = [self.rp.roadsecs[1], self.rp.roadsecs[0], True, False, True]
        self.rp.updateOntoFromState(state)
        print(self.rp.getState())
        self.assertEqual(self.rp.getState(), state)

    def testNewWorld(self):
        newWorld = World()
        onto = newWorld.get_ontology(self.rp.roadWithIndividuals).load()
        print(onto.Agent.instances())
        print(onto.RoadSection.instances())

if __name__ == "__main__":
    print("Road Planner")
    rp = RoadProblem()
    rp.bfs()