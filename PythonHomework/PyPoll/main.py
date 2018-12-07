import os
import csv

election_data_csv = os.path.join("..", "..", "PythonHomework", "PyPoll", "election_data.csv")

with open(election_data_csv, 'r', newline='') as csvfile:
    csvreader = csv.DictReader(csvfile)
    ###for row in csvreader:
        ###print(row['Voter ID'])

# Ask 1 : Get total tumber of votes cast
    row_count = sum(1 for row in csvreader)
    ###print(row_count)


with open(election_data_csv, 'r', newline='') as csvfile:
    csvreader = csv.DictReader(csvfile)

# Ask 2 : A complete list of candidates that received votes
    
    # parse 'Candidates' from dict as string list
    candidates_list = [str(row['Candidate']) for row in csvreader]
    ###print candidates_list
    
    # call each candidate name from list using 'set', order set so its not random every run
    candidates = set(candidates_list)
    sorted_candidates = sorted(candidates)
    ###print(sorted_candidates)

    # return 'sorted set' to 'list'
    new_candidate_list = list(sorted_candidates)
    ###print(new_candidate_list)

# Ask 4 : Get total number of votes per candidate

    # use 'counter' to return dict of 'candidate : votes' from raw candidates list
    from collections import Counter
    candidate_vote_count = Counter(candidates_list)
    ###print(candidate_vote_count)

# Ask 3 : Get percent of votes each candidate won

    # Get each candidates vote count from 'candidate_vote_count', divide by total votes cast
    khan_percentage = round((candidate_vote_count['Khan'] / row_count)*100, 0)
    ###print(khan_percentage)
    correy_percentage = round((candidate_vote_count['Correy'] / row_count)*100, 0)
    ###print(correy_percentage)
    otooley_percentage = round((candidate_vote_count["O'Tooley"] / row_count)*100, 0)
    ###print(otooley_percentage)
    li_percentage = round((candidate_vote_count['Li'] / row_count)*100, 0)
    ###print(li_percentage)

# Ask 5 : Determine winner of election by popular vote

    # Use max of candidate vot count dict
    winner = max(candidate_vote_count, key=candidate_vote_count.get)
    ###print(winner)

# ---------------------------------------------------------------------------------------------

# Print output to terminal
print('')
print('Election Results')
print('----------------------')
print('Total Votes: ' + str(row_count))
print('----------------------')
print(new_candidate_list[1] + ': ' + str(khan_percentage) + ' ' + '(' + str(candidate_vote_count['Khan']) + ')')
print(new_candidate_list[0] + ': ' + str(correy_percentage) + ' ' + '(' + str(candidate_vote_count['Correy']) + ')')
print(new_candidate_list[2] + ': ' + str(li_percentage) + ' ' + '(' + str(candidate_vote_count['Li']) + ')')
print(new_candidate_list[3] + ': ' + str(otooley_percentage) + ' ' + '(' + str(candidate_vote_count["O'Tooley"]) + ')')
print('')
print('Winner: ' + winner)
print('')


# Print output to TextFile
import sys
sys.stdout=open("output.txt","w")
print('')
print('Election Results')
print('----------------------')
print('Total Votes: ' + str(row_count))
print('----------------------')
print(new_candidate_list[1] + ': ' + str(khan_percentage) + ' ' + '(' + str(candidate_vote_count['Khan']) + ')')
print(new_candidate_list[0] + ': ' + str(correy_percentage) + ' ' + '(' + str(candidate_vote_count['Correy']) + ')')
print(new_candidate_list[2] + ': ' + str(li_percentage) + ' ' + '(' + str(candidate_vote_count['Li']) + ')')
print(new_candidate_list[3] + ': ' + str(otooley_percentage) + ' ' + '(' + str(candidate_vote_count["O'Tooley"]) + ')')
print('')
print('Winner: ' + winner)
print('')
sys.stdout.close()




    


    
    
    