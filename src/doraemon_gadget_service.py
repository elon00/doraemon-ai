# -*- coding: utf-8 -*-
import hashlib
import time
import json

class DoraemonPocketAgent:
    def __init__(self, cat_robot: str = "Doraemon", favorite_snack: str = "Dorayaki"):
        self.cat_robot = cat_robot
        self.favorite_snack = favorite_snack
        self.gadgets_in_pocket = [
            "Anywhere Door", "Bamboo Copter", "Time Cloth",
            "Small Light", "Translation Konjac", "Pass Loop"
        ]

    def draw_from_4d_pocket(self, problem_description: str) -> dict:
        selected_gadget = self.gadgets_in_pocket[hash(problem_description) % len(self.gadgets_in_pocket)]
        dispense_id = hashlib.sha256(f"{problem_description}:{selected_gadget}:{time.time()}".encode()).hexdigest()[:16]
        return {
            "robot": self.cat_robot,
            "problem": problem_description,
            "dispensed_gadget": selected_gadget,
            "pocket_dimension": "4-Dimensional Subspace",
            "spatial_teleport_ready": True,
            "ticket_id": f"DORA-4D-{dispense_id}",
            "dorayaki_fee_paid": 1.0,
            "timestamp": int(time.time())
        }

if __name__ == "__main__":
    agent = DoraemonPocketAgent()
    res = agent.draw_from_4d_pocket("Need to attend meeting in Tokyo in 2 seconds")
    print("4D Pocket Gadget Result:", json.dumps(res, indent=2))
