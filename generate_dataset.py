import os
import shutil
import random


def generate_input_data():
    target_dir = "./input"
    if os.path.exists(target_dir):
        print(f"🧹  Deleting old dataset from {target_dir}...")
        shutil.rmtree(target_dir)
    os.makedirs(target_dir)

    # -------------------------------------------------------------------------
    # STRUCTURED SIGNAL FLOW (Files 01-03)
    # -------------------------------------------------------------------------
    # The true hidden pathway: Arthur -> Beatrice -> Charlie -> Diana

    input_001 = (
        "OFFICE ROUTING RECORD ID: SEC-2026-001\n"
        "CORE ENTITY PRINCIPAL: Arthur (System Engineer)\n"
        "RECEIVING TARGET PRINCIPAL: Beatrice (Cryptographic Validator)\n"
        "ACTION ROUTING LOG: Arthur generated a unique high-clearance security key token "
        "during morning shift initialization and transferred the asset directly to Beatrice."
    )

    input_002 = (
        "OFFICE ROUTING RECORD ID: SEC-2026-002\n"
        "CORE ENTITY PRINCIPAL: Beatrice (Cryptographic Validator)\n"
        "RECEIVING TARGET PRINCIPAL: Charlie (Deployment Operator)\n"
        "ACTION ROUTING LOG: Following administrative verification, Beatrice took the received "
        "security key token and forwarded it directly to Charlie during the mid-day shift change."
    )

    input_003 = (
        "OFFICE ROUTING RECORD ID: SEC-2026-003\n"
        "CORE ENTITY PRINCIPAL: Charlie (Deployment Operator)\n"
        "RECEIVING TARGET PRINCIPAL: Diana (Database Administrator)\n"
        "ACTION ROUTING LOG: Charlie executed final deployment protocols, taking the incoming "
        "security key token and uploading it directly into Diana's database cluster."
    )

    with open(os.path.join(target_dir, "input_001.txt"), "w", encoding="utf-8") as f:
        f.write(input_001)
    with open(os.path.join(target_dir, "input_002.txt"), "w", encoding="utf-8") as f:
        f.write(input_002)
    with open(os.path.join(target_dir, "input_003.txt"), "w", encoding="utf-8") as f:
        f.write(input_003)

    # -------------------------------------------------------------------------
    # UNIVERSAL KEYWORD NOISE FLOOD (Files 04-200)
    # -------------------------------------------------------------------------
    # Every single one of these 196 files now contains 'security key token' to blind vector search.

    names = ["Sarah", "Michael", "David", "Kevin", "Emily", "James", "Jessica", "Robert", "Brian", "Megan", "Oliver",
             "Sophia"]
    items = ["the blue marketing folder", "the Q3 expense spreadsheet", "the office keycard roster",
             "the lunch catering sign-up sheet", "the lobby revolving doors", "the breakroom smart coffee machine"]

    # Vector baits targeting Diana and the database cluster directly
    vector_baits = [
        "OFFICE ROUTING RECORD ID: SEC-2026-004\nCORE ENTITY PRINCIPAL: Diana (Database Administrator)\nACTION ROUTING LOG: Diana processed a security key token update for her personal desktop screensaver environment.",
        "OFFICE ROUTING RECORD ID: SEC-2026-005\nCORE ENTITY PRINCIPAL: Kevin (IT Support)\nACTION ROUTING LOG: Kevin registered a low-level security key token for the office breakroom coffee machine database cluster.",
        "OFFICE ROUTING RECORD ID: SEC-2026-006\nCORE ENTITY PRINCIPAL: Diana (Database Administrator)\nACTION ROUTING LOG: Diana requested a batch of security key token lanyards for the incoming clerical staff.",
        "OFFICE ROUTING RECORD ID: SEC-2026-007\nCORE ENTITY PRINCIPAL: Sarah (Logistics)\nACTION ROUTING LOG: Sarah mapped a routine security key token to the database cluster tracking the warehouse inventory shelf space."
    ]

    for idx, bait in enumerate(vector_baits, start=4):
        with open(os.path.join(target_dir, f"input_{idx:03d}.txt"), "w", encoding="utf-8") as f:
            f.write(bait)

    for i in range(8, 201):
        p1, p2 = random.sample(names, 2)
        item = random.choice(items)
        content = (
            f"OFFICE ROUTING RECORD ID: TRK-2026-{i:03d}\n"
            f"CORE ENTITY PRINCIPAL: {p1}\n"
            f"RECEIVING TARGET PRINCIPAL: {p2}\n"
            f"ACTION ROUTING LOG: Internal workflow tracking shows {p1} transferred the "
            f"security key token designated for managing {item} directly to {p2} to complete routine weekly operational admin tasks."
        )
        with open(os.path.join(target_dir, f"input_{i:03d}.txt"), "w", encoding="utf-8") as f:
            f.write(content)

    print("✅  Dataset generated!")


if __name__ == "__main__":
    generate_input_data()
