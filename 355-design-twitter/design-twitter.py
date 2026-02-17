import heapq
from collections import defaultdict

class Twitter(object):

    def __init__(self):
        self.heap = []
        self.co = 0
        self.dic = defaultdict(set)
    def postTweet(self, userId, tweetId):
        heapq.heappush(self.heap, (-self.co, userId, tweetId))
        self.co += 1
    def getNewsFeed(self, userId):
        result = []
        temp_heap = list(self.heap)
        users_to_include = {userId}
        if userId in self.dic:
            users_to_include.update(self.dic[userId])
        relevant_tweets = []
        for neg_co,u,tweetid in temp_heap:
            if u in users_to_include:
                relevant_tweets.append((neg_co, tweetid))
        relevant_tweets.sort()
        for i in range(min(10, len(relevant_tweets))):
            result.append(relevant_tweets[i][1])
        return result
    def follow(self, followerId, followeeId):
        if followerId != followeeId:
            self.dic[followerId].add(followeeId)
    def unfollow(self, followerId, followeeId):
        if followerId in self.dic and followeeId in self.dic[followerId]:
            self.dic[followerId].remove(followeeId)