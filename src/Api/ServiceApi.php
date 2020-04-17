<?php


namespace App\Api;


use GuzzleHttp\Client;

class ServiceApi
{
    public $uri = "http://172.30.0.9/api/v2";
    public  $apikey = "a80df37937fb2bf2f3e71b38ce3ad01ef8acef97e93e27c24f2eb0db56d6797f";

    public static function getToken()
    {
        $body = ["email"=> "yoannraza01@gmail.com",
            "password" => "azertyui",
            "duration" => 60000,
        ];
        $client = new Client();
        $request = $client->request('POST', "http://172.30.0.9/api/v2/user/session",['body' => json_encode($body)]);
        $array=json_decode($request->getBody(),true);
        $token=$array['session_token'];
        return $token;
    }

    public function createUser($user, $token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $newDate = date("Y-m-d", strtotime($user["birth_date"]));
        $user["birth_date"] = $newDate;
        $user["created"] = $today;
        $user["updated"] = $today;
        $body = ["resource"=>[$user]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/user",[
            'headers' => [ 'X-DreamFactory-API-Key' => "a80df37937fb2bf2f3e71b38ce3ad01ef8acef97e93e27c24f2eb0db56d6797f",
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        $user_id= $response['resource'][0]["id"];
        return $user_id;
    }

    public function createAdress($adress,$user_id, $token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $adress["created"] = $today;
        $adress["updated"] = $today;
        $adress["user_id"]= $user_id;
        $body = ["resource"=>[$adress]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/address",[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getUser($user_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/user/".$user_id, [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getAllUserWithAddressAd($token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/user?related=ad_by_user_id,address_by_user_id" ,[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }



    public function getAllCategory($token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/category/", [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getAllAd($token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/ad", [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getAd($ad_user,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/ad/".$ad_user."?related=user_by_user_id,category_by_category_id", [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getAddressByUserId($user_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/address?filter=user_id%20=%20".$user_id, [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getConversationByAdId($ad_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/conversation?related=message_by_conversation_id&filter=ad_id%20=%20".$ad_id, [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getMessageByConversationId($conversation_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/message?related=user_by_sender_id&filter=conversation_id%20=%20".$conversation_id, [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getConversation($conversation_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/conversation/".$conversation_id."?related=ad_by_ad_id", [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function getMessageByUserId($user_id,$token)
    {
        $client = new Client();
        $request=$client->request('GET',$this->uri."/ipssi/_table/message?related=user_by_sender_id&filter=sender_id%20=%20".$user_id, [
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token]]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function createAd($ad,$user_id, $token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $ad["created"] = $today;
        $ad["updated"] = $today;
        $ad["user_id"]= $user_id;
        $ad['status']= "enabled";
        $body = ["resource"=>[$ad]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/ad",[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function createMission($ad_id,$user_id, $token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $mission["created"] = $today;
        $mission["updated"] = $today;
        $mission["ad_id"]= $ad_id;
        $mission['customer_id']= $user_id;
        $body = ["resource"=>[$mission]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/mission",[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function createConversation($ad_id, $token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $conversation["created"] = $today;
        $conversation["updated"] = $today;
        $conversation["ad_id"]= $ad_id;
        $body = ["resource"=>[$conversation]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/conversation",[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }

    public function createMessage($user_id, $conversation_id, $text,$token)
    {
        $client = new Client();
        $today = date("Y-m-d H:i:s");
        $conversation["content"] = $text;
        $conversation["created"] = $today;
        $conversation["updated"] = $today;
        $conversation["conversation_id"] = $conversation_id;
        $conversation["sender_id"]= $user_id;
        $body = ["resource"=>[$conversation]];
        $request = $client->request('POST', $this->uri."/ipssi/_table/message",[
            'headers' => [ 'X-DreamFactory-API-Key' => $this->apikey,
                'X-DreamFactory-Session-Token' => $token],
            'body' => json_encode($body)]);
        $response=json_decode($request->getBody(),true);
        return $response;
    }



}