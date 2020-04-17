<?php


namespace App\Controller;

use App\Api\ServiceApi;
use DateInterval;
use DateTime;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Session\Session;


class ApiController extends AbstractController
{
    /**
     * @Route("/user",name="user_show")
     */
    public function showUser(Request $request, ServiceApi $serviceApi)
    {

        $token = $this->verifToken($request);
        if($request->query->get("id")){
            $user_id = $request->query->get("id");
            $user = $serviceApi->getUser($user_id, $token);
            $messages = $serviceApi->getMessageByUserId($user_id, $token);
            $conversations = [];
            $ads = [];
            foreach( $messages["resource"] as $message )
            {
                if (!in_array($message["conversation_id"], $conversations)) {
                    array_push($conversations, $message["conversation_id"]);
                }
            }
            foreach( $conversations as $conversation ){
                $response = $serviceApi->getConversation($conversation, $token);
                array_push($ads, $response);
            }
            return $this->render('user/show.html.twig', [
                'user' => $user,
                'ads' => $ads
            ]);
        }
        return $this->render('user/search.html.twig');
    }


    /**
     * @Route("/user/new",name="new_user")
     */
    public function newUser(Request $request, ServiceApi $serviceApi){
        $token = $this->verifToken($request);
        if($request->isMethod('post')){
            $user = $request->request->all();
            $user_id = $serviceApi->createUser($user, $token);
            $response = $serviceApi->createAdress($user, $user_id, $token);
            $obj_user= $serviceApi->getUser($user_id, $token);
            return $this->redirectToRoute('user_show', ['id' => $user_id]);
        }
        return $this->render('user/form.html.twig');
    }



//    /**
//     * @Route("/ad",name="ad_index")
//     */
//    public function show_ad(Request $request, ServiceApi $serviceApi)
//    {
//
//        $token = $this->verifToken($request);
//        if($request->query->get("id")){
//            $user_id = $request->query->get("id");
//            $ads = $serviceApi->getAllAd($token);
//            return $this->render('ad/index.html.twig', [
//                'ads' => $ads,
//                'user_id' => $user_id
//            ]);
//        }else{
//            return $this->redirectToRoute('user_show');
//        }
//
//    }

    /**
     * @Route("/ad",name="ad_index")
     */
    public function show_ad(Request $request, ServiceApi $serviceApi)
    {

        $token = $this->verifToken($request);
        if($request->query->get("id")){
            $user_id = $request->query->get("id");
            $users = $serviceApi->getAllUserWithAddressAd($token);
            return $this->render('ad/index.html.twig', [
                'users' => $users,
                'user_id' => $user_id
            ]);
        }else{
            return $this->redirectToRoute('user_show');
        }

    }

    /**
     * @Route("/ad/new",name="new_ad")
     */
    public function newAd(Request $request, ServiceApi $serviceApi){
        if(!$request->query->get("id")) {
            return $this->redirectToRoute('user_show');
        }
        $token = $this->verifToken($request);
        $user_id = $request->query->get("id");
        $categories = $serviceApi->getAllCategory($token);
        if($request->isMethod('post')){
            $ad = $request->request->all();
            $response = $serviceApi->createAd($ad, $user_id, $token);
            $ad_id= $response['resource'][0]["id"];
            $conversation = $serviceApi->createConversation($ad_id, $token);
            return $this->redirectToRoute('ad_index',["id"=>$user_id]);
        }
        return $this->render('ad/form.html.twig',[
            "categories"=>$categories,
            "user_id"=>$user_id
        ]);
    }

    /**
     * @Route("/ad/show",name="ad_show")
     */
    public function showAd(Request $request, ServiceApi $serviceApi)
    {

        $token = $this->verifToken($request);
        $user_id=$request->query->get("id");
        $ad_id=$request->query->get("ad_id");
        $ad = $serviceApi->getAd($ad_id,$token);
        $conversation = $serviceApi->getConversationByAdId($ad_id, $token);
        $messages = $serviceApi->getMessageByConversationId($conversation['resource'][0]["id"],$token);
        $address = $serviceApi->getAddressByUserId($ad["user_id"],$token);
        return $this->render('ad/show.html.twig', [
            'user_id' => $user_id,
            'ad' => $ad,
            'address' => $address,
            'conversation'=> $conversation,
            'messages'=> $messages
        ]);

    }

    /**
     * @Route("/mission/new",name="new_mission")
     */
    public function newMission(Request $request, ServiceApi $serviceApi){
        $token = $this->verifToken($request);
        $user_id = $request->query->get("id");
        $ad_id = $request->query->get("ad_id");
        $ad = $serviceApi->getAd($ad_id,$token);
        $address = $serviceApi->getAddressByUserId($ad["user_id"],$token);
        $categories = $serviceApi->createMission($ad_id, $user_id, $token);
        $conversation = $serviceApi->getConversationByAdId($ad_id, $token);
        $messages = $serviceApi->getMessageByConversationId($conversation['resource'][0]["id"],$token);
        $this->addFlash('success', 'the mission is added');
        return $this->render('ad/show.html.twig', [
            'user_id' => $user_id,
            'ad' => $ad,
            'address' => $address,
            'messages'=> $messages,
            'conversation'=> $conversation,
        ]);

    }

    /**
     * @Route("/message/new",name="new_message")
     */
    public function newMessage(Request $request, ServiceApi $serviceApi){
        $token = $this->verifToken($request);
        $ad_id = $request->query->get("ad_id");
        $ad = $serviceApi->getAd($ad_id,$token);
        $address = $serviceApi->getAddressByUserId($ad["user_id"],$token);
        $user_id = $request->query->get("id");
        $conversation_id = $request->query->get("conversation_id");
        $content = $request->request->get('content');
        $categories = $serviceApi->createMessage($user_id, $conversation_id, $content,$token);
        $conversation = $serviceApi->getConversationByAdId($ad_id, $token);
        $messages = $serviceApi->getMessageByConversationId($conversation['resource'][0]["id"],$token);


        $this->addFlash('success', 'the message is added');
        return $this->render('ad/show.html.twig', [
            'user_id' => $user_id,
            'ad' => $ad,
            'address' => $address,
            'conversation'=> $conversation,
            'messages'=> $messages
        ]);
    }

    public function verifToken($request){
        if (!$request->hasSession() || !($session = $request->getSession()))
        {
            $session = $request->getSession();
            $dateExpire =$session ->get('dateExpire');
            if(new DateTime()>$dateExpire){
                $token = ServiceApi::getToken();
                $session->set('token',$token);
                $dateExpire = new DateTime();
                date_add($dateExpire, date_interval_create_from_date_string("60000 secs"));
                $session->set('dateExpire',$dateExpire);
            }else{
                $token = $session ->get('token');
            }
        }
        else{
            $session = new Session();
            $token = ServiceApi::getToken();
            $session->set('token',$token);
            $dateExpire = new DateTime();
            date_add($dateExpire, date_interval_create_from_date_string("60000 secs"));
            $session->set('dateExpire',$dateExpire);
        }
        return $token;
    }


}